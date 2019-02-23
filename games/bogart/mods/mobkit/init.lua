-- yaw values:
-- x+ = -pi/2
-- x- = +pi/2
-- z+ = 0
-- z- = -pi

mobkit={}

mobkit.gravity = -9
mobkit.friction = 0.5

local abs = math.abs
local pi = math.pi
local floor = math.floor
local random = math.random

local neighbors ={
	{x=1,z=0},
	{x=1,z=1},
	{x=0,z=1},
	{x=-1,z=1},
	{x=-1,z=0},
	{x=-1,z=-1},
	{x=0,z=-1},
	{x=1,z=-1}
	}

-- UTILITY FUNCTIONS

function mobkit.pos_shift(pos,vec)
	vec.x=vec.x or 0
	vec.y=vec.y or 0
	vec.z=vec.z or 0
	return {x=pos.x+vec.x,
			y=pos.y+vec.y,
			z=pos.z+vec.z}
end

function mobkit.nodeatpos(pos)
	return minetest.registered_nodes[minetest.get_node(pos).name]
end

function mobkit.get_nodename_off(pos,vec)
	return minetest.get_node(mobkit.pos_shift(pos,vec)).name
end

function mobkit.get_node_pos(pos)
	return  {
			x=floor(pos.x+0.5),
			y=floor(pos.y+0.5),
			z=floor(pos.z+0.5),
			}
end

function mobkit.get_hitbox_bottom(self)
	local y = self.collisionbox[2]
	local pos = self.object:get_pos()
	return {
			{x=pos.x+self.collisionbox[1],y=pos.y+y,z=pos.z+self.collisionbox[3]},
			{x=pos.x+self.collisionbox[1],y=pos.y+y,z=pos.z+self.collisionbox[6]},
			{x=pos.x+self.collisionbox[4],y=pos.y+y,z=pos.z+self.collisionbox[3]},
			{x=pos.x+self.collisionbox[4],y=pos.y+y,z=pos.z+self.collisionbox[6]},
		}
end
		
function mobkit.get_node_height(pos)
	local npos = mobkit.get_node_pos(pos)
	local node = mobkit.nodeatpos(npos)
	if node.walkable then
		if node.drawtype == 'nodebox' then
			if node.node_box.type == 'fixed' then
				if type(node.node_box.fixed[1]) == 'number' then
					return npos.y + node.node_box.fixed[5] ,0
				elseif type(node.node_box.fixed[1]) == 'table' then
					return npos.y + node.node_box.fixed[1][5] ,0
				else
					return npos.y + 0.5,1			-- todo handle table of boxes
				end		
			elseif node.node_box.type == 'leveled' then
				return minetest.get_node_level(pos)/64-0.5+mobkit.get_node_pos(pos).y, 0
			else
				return npos.y + 0.5,1	-- the unforeseen
			end
		else
			return npos.y+0.5,1	-- full node
		end
	else
		return npos.y-0.5,-1	-- not walkable
	end
end

function mobkit.get_terrain_height(pos,steps,dir) --dir is 1=up, -1=down, 0=both 
	steps = steps or 3
	dir = dir or 0
	local h,f = mobkit.get_node_height(pos)
	if f==0 or steps == 0 then 
		return h
	end
	steps = steps - 1
	if dir==0 or dir==f then
		return mobkit.get_terrain_height(mobkit.pos_shift(pos,{y=f}),steps,f)
	else
		return h
	end
end

function mobkit.turn2yaw(self,tyaw)
	tyaw = tyaw or 0 --temp
		local yaw = self.object:get_yaw()

		local diff = tyaw-yaw
		local step = self.dtime*4
		
		if abs(diff)<step then
			self.object:set_yaw(tyaw)
			return true
		end

		local dirmod = abs(diff) > pi and -1 or 1

		local nyaw = diff < 0 and yaw+step*-dirmod or yaw+step*dirmod

		if nyaw > pi then
			nyaw=nyaw-pi*2
		elseif nyaw < -pi then
			nyaw=nyaw+pi*2
		end
		self.object:set_yaw(nyaw)
end

function mobkit.isnear2d(p1,p2,thresh)
	if abs(p2.x-p1.x) < thresh and abs(p2.z-p1.z) < thresh then
		return true
	else
		return false
	end
end

function mobkit.is_neighbor_node_reachable(self,neighbor)	-- todo: take either number or pos
	local offset = neighbors[neighbor]
	local pos=self.object:get_pos()
	local tpos = mobkit.get_node_pos(mobkit.pos_shift(pos,offset))
	local height = mobkit.get_terrain_height(tpos) - pos.y
	if abs(height) <= self.jump_height then
	
		-- don't cut corners
		if neighbor % 2 == 0 then				-- diagonal neighbors are even
			local n2 = neighbor-1				-- left neighbor never < 0
			offset = neighbors[n2]
			local t2 = mobkit.get_node_pos(mobkit.pos_shift(pos,offset))
			if mobkit.get_terrain_height(t2) - pos.y > 0 then return end
			n2 = (neighbor+1)%8 		-- right neighbor
			offset = neighbors[n2]
			t2 = mobkit.get_node_pos(mobkit.pos_shift(pos,offset))
			if mobkit.get_terrain_height(t2) - pos.y > 0 then return end
		end
		
		-- check headroom, dumb for now
		if mobkit.nodeatpos(mobkit.pos_shift(pos,{y=self.height+1})).walkable or
		mobkit.nodeatpos(mobkit.pos_shift(tpos,{y=self.height})).walkable then
			return 
		end
		
	return height, tpos
	else
		return
	end
end

function mobkit.queue_high(self,func,priority)
	table.insert(self.hqueue,{func=func,prty=priority})
end

function mobkit.queue_low(self,func)
	table.insert(self.lqueue,func)
end

function mobkit.is_queue_empty_low(self)
	if #self.lqueue == 0 then return true
	else return false end
end

function mobkit.is_queue_empty_high(self)
	if #self.hqueue == 0 then return true
	else return false end
end

local function execute_queues(self)
	--Execute hqueue
	if #self.hqueue > 0 then
		local func = self.hqueue[1].func
		if func(self) then
			table.remove(self.hqueue,1)
			self.lqueue = {}
		end
	end
	-- Execute lqueue
	if #self.lqueue > 0 then
		local func = self.lqueue[1]
		if func(self) then
			table.remove(self.lqueue,1)
		end
	end
end


----------------------------
-- LOW LEVEL QUEUE FUNCTIONS
----------------------------

function mobkit.lq_turn2pos(self,tpos)
	local func=function(self)
		local pos = self.object:get_pos()
		return mobkit.turn2yaw(self,
			minetest.dir_to_yaw(vector.direction(pos,tpos)))
	end
	mobkit.queue_low(self,func)
end

function mobkit.lq_idle(self,duration)
	local func=function(self)
		duration = duration-self.dtime
		if duration <= 0 then return true end
	end
	mobkit.queue_low(self,func)
end

function mobkit.lq_dumbwalk(self,dest)
	local timer = 3			-- failsafe
	local func=function(self)
		timer = timer - self.dtime
		if timer < 0 then return true end
		
		local pos = self.object:get_pos()
		local y = self.object:get_velocity().y
		if mobkit.isnear2d(pos,dest,0.1) then
			self.object:set_velocity({x=0,y=y,z=0})
			return true 
		end

		if self.isonground then
			local dir = vector.normalize(vector.direction({x=pos.x,y=0,z=pos.z},
														{x=dest.x,y=0,z=dest.z}))
			self.object:set_yaw(minetest.dir_to_yaw(dir))
			dir = vector.multiply(dir,self.walk_speed)
			dir.y = y
			self.object:set_velocity(dir)
		end
	end
	mobkit.queue_low(self,func)
end

-- initial velocity for jump height h, v= a*sqrt(h*2/a) ,add 20%
function mobkit.lq_dumbjump(self,height)
	local jump = true
	local func=function(self)
	local yaw = self.object:get_yaw()
		if self.isonground then
			if jump then
				local dir = minetest.yaw_to_dir(yaw)
				dir.y = -mobkit.gravity*math.sqrt((height+0.3)*2/-mobkit.gravity)
				self.object:set_velocity(dir)
				jump = false
			else				-- the eagle has landed
				return true
			end
		else	
			local dir = minetest.yaw_to_dir(yaw)
			local vel = self.object:get_velocity()
			if self.lastvelocity.y < 0.9 then
				dir = vector.multiply(dir,2)
			end
			dir.y = vel.y
			self.object:set_velocity(dir)
		end
	end
	mobkit.queue_low(self,func)
end

-----------------------------
-- HIGH LEVEL QUEUE FUNCTIONS
-----------------------------

function mobkit.hq_roam(self)
	local func=function(self)
		if #self.lqueue == 0 and self.isonground then
			local pos = self.object:get_pos()
			local neighbor = random(8)

			local height, tpos = mobkit.is_neighbor_node_reachable(self,neighbor)
			if not height then return end
			 
			if height <= 0 then
				mobkit.lq_turn2pos(self,tpos) 
				mobkit.lq_dumbwalk(self,tpos)
			else
				mobkit.lq_turn2pos(self,tpos) 
				mobkit.lq_dumbjump(self,height) 
			end
		end
	end
	mobkit.queue_high(self,func,0)
end

------------
-- CALLBACKS
------------

function mobkit.default_brain(self)
	if mobkit.is_queue_empty_high(self) then mobkit.hq_roam(self) end
end

function mobkit.actfunc(self, staticdata, dtime_s)
	self.lqueue = {}
	self.hqueue = {}
	self.lastvelocity = {x=0,y=0,z=0}
	self.height = self.collisionbox[5] - self.collisionbox[2]
end

function mobkit.stepfunc(self,dtime)	-- not intended to be modified
	self.dtime = dtime
-- physics comes first
	self.object:set_acceleration({x=0,y=mobkit.gravity,z=0})
	local vel = self.object:get_velocity()
	
	if self.lastvelocity.y == vel.y then
		self.isonground = true
	else
		self.isonground = false
	end
	
	-- dumb friction
	if self.isonground then
		self.object:set_velocity({x= vel.x> 0.2 and vel.x*mobkit.friction or 0,
								y=vel.y,
								z=vel.z > 0.2 and vel.z*mobkit.friction or 0})
	end
	
-- bounciness
	if self.springiness > 0 then
		local vnew = vector.new(vel)
		
		if not self.collided then						-- ugly workaround for inconsistent collisions
			for _,k in ipairs({'y','z','x'}) do			
				if vel[k]==0 and abs(self.lastvelocity[k])> 0.1 then 
					vnew[k]=-self.lastvelocity[k]*self.springiness 
				end
			end
		end
		
		if not vector.equals(vel,vnew) then
			self.collided = true
		else
			if self.collided then
				vnew = vector.new(self.lastvelocity)
			end
			self.collided = false
		end
	
		self.object:set_velocity(vnew)
	end

	-- now we're thinking
	if self.brainfunc then
		self:brainfunc()
		execute_queues(self)
	end
	
	self.lastvelocity = self.object:get_velocity()
end