local S = ...

petz = {}

petz.register_cubic = function(node_name, fixed, tiles)
		minetest.register_node(node_name, {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = fixed,
		},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
    	groups = {not_in_creative_inventory = 1},
	})		
end

petz.settings = {}
petz.settings.mesh = nil
petz.settings.visual_size = {}
petz.settings.rotate = 0

--
--Form Dialog
--

--Context
petz.pet = {} -- A table of pet["owner_name"]="owner_name"

petz.create_form = function(player_name, pet_name)
    local pet = petz.pet[player_name]
    if pet.affinity == nil then
       pet.affinity = 0
    end
	local form_pet_orders
    if petz.settings.tamagochi_mode == true then        
		form_pet_orders = 
            "size[5,5;]"..
            "image[0,0;1,1;petz_spawnegg_"..pet_name..".png]"..
            "label[1,0;".. S("Orders").."]"..
            "image[3,1;1,1;petz_affinity_heart.png]"..
            "label[4,1;".. tostring(pet.affinity).."%]"..
            "image[3,2;1,1;petz_pet_bowl_inv.png]"
        local hungry_label = ""
        if pet.fed == false then
            hungry_label = "Hungry"
        else
            hungry_label = "Saciated"
        end
        form_pet_orders = form_pet_orders .. "label[4,2;"..S(hungry_label).."]"
    else
        form_pet_orders =
            "size[3,5;]"..
            "image[1,0;1,1;petz_spawnegg_"..pet_name..".png]"
    end
    form_pet_orders = form_pet_orders..
		"button_exit[0,1;3,1;btn_followme;"..S("Follow me").."]"..
		"button_exit[0,2;3,1;btn_standhere;"..S("Stand here").."]"..
		"button_exit[0,3;3,1;btn_ownthing;"..S("Do your own thing").."]"..	
		"button_exit[1,4;1,1;btn_close;"..S("Close").."]"
	return form_pet_orders
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (formname ~= "petz:form_orders") then
		return false
	end
    local pet = petz.pet[player:get_player_name()] 
	if pet == nil then -- if pet dies after her formspec opened
		return false
	end
	--brewing.magic_sound("to_player", player, "brewing_select")
	if fields.btn_followme then
		pet.order = "follow"
	elseif fields.btn_standhere then
		pet.order = "stand"
	elseif fields.btn_ownthing then
		pet.order = ""
		pet.state = "walk"
	end
	return true
end)

--
-- Increase/Descrease the pet affinity
--

petz.set_affinity = function(self, increase, amount)
    local new_affinitty
    if increase == true then
        new_affinitty = self.affinity +  amount
    else
        new_affinitty = self.affinity -  amount
    end
    if new_affinitty > 100 then
        new_affinitty = 100
    elseif new_affinitty <0 then     
        new_affinitty = 0
    end
    self.affinity = new_affinitty
end

--
--The Timer for the Tamagochi Mode

petz.timer = function(self, pet_name)
    minetest.after(petz.settings.tamagochi_check_time, function(self, pet_name) 
        --decrease affinity
        if not(self.object== nil) then
            --Decrease affinitty always a bit amount because the pet lost some affinitty
            petz.set_affinity(self, false, 10)
            --Decrease health if pet has not fed
            if self.fed == false then
                local current_health = self.health
                new_health = current_health - petz.settings.tamagochi_hunger_damage
                if new_health>=0  then
                    self.health = new_health
                    petz.set_affinity(self, false, 33)
                else
                    self.health = 0
                end
            end
            --If the pet has not brushed
            if self.brushed == false then
                petz.set_affinity(self, false, 20)
            end
            --Reset the variables
            self.fed = false
            self.brushed = false
            --If the pet starves to death
            if self.health == 0 then
                minetest.chat_send_player(self.owner, S("Your").. " "..pet_name.." "..S("has starved to death!!!"))
                self.init_timer  = false -- no more timing
            --I the pet get bored of you
            elseif self.affinity == 0 then
                minetest.chat_send_player(self.owner, S("Your").." "..pet_name.." "..S("has abandoned you!!!"))
                self.owner = "" --the pet abandon you
                self.init_timer  = false -- no more timing
            --Else reinit the timer, to check again in the future
            else
                self.init_timer  = true
            end
        end
    end, self, pet_name)
    self.init_timer = false --the timer is reinited in the minetest.after function
end

--
--Mobs Redo Events
--

petz.on_rightclick = function(self, clicker, pet_name)
        if not(clicker:is_player()) then
            return false
        end
        local player_name = clicker:get_player_name()
        local wielded_item = clicker:get_wielded_item()
        local wielded_item_name= wielded_item:get_name()
        --If brushing
        if wielded_item_name == "petz:hairbrush" then
            if (self.owner ~= player_name) then
                return
            end           
            if petz.settings.tamagochi_mode == true and self.brushed == false then                
                petz.set_affinity(self, true, 5)                
                self.brushed = true               
            elseif petz.settings.tamagochi_mode == true and self.brushed == true then  
                minetest.chat_send_player(self.owner, S("Your").." "..pet_name.." "..S("had already been brushed."))
            end
            petz.do_sound_effect("object", self.object, "petz_brushing")
            petz.do_particles_effect(self.object, self.object:get_pos(), "star")            
        --If feeded
        elseif mobs:feed_tame(self, clicker, 5, false, true) then
            if petz.settings.tamagochi_mode == true and self.fed == false then
                petz.set_affinity(self, true, 5)                
                self.fed = true               
            end
            petz.do_sound_effect("object", self.object, "petz_"..pet_name.."_moaning")
            petz.do_particles_effect(self.object, self.object:get_pos(), "heart")   
        --Else open the Form
        else            
            petz.pet[player_name]= self
            minetest.show_formspec(player_name, "petz:form_orders", petz.create_form(player_name, pet_name))
        end
end

petz.on_die = function(self, pos)
    petz.pet[self.owner]= nil
end

petz.do_punch = function (self, hitter, time_from_last_punch, tool_capabilities, direction)
    if petz.settings.tamagochi_mode == true then         
        if self.owner == hitter:get_player_name() then
            if self.affinity == nil then
                self.affinity = 0       
            end
            self.affinity = self.affinity - 20
        end
    end
end

--
--Effects
--

petz.do_particles_effect = function(obj, pos, particle_type)
    local minpos
    minpos = {
        x = pos.x,
        y = pos.y,
        z = pos.z
    }        
    local maxpos
    maxpos = {
        x = minpos.x+0.4,
        y = minpos.y-0.5,
        z = minpos.z+0.4
    }    
    local texture_name
    local particles_amount
    if particle_type == "star" then
        texture_name = "petz_star_particle.png"
        particles_amount = 20
    elseif particle_type == "heart" then
        texture_name = "petz_affinity_heart.png"
        particles_amount = 10
    end
    minetest.add_particlespawner({
        --attached = obj,
        amount = particles_amount,
        time = 1.5,
        minpos = minpos,
        maxpos = maxpos,
        --minvel = {x=1, y=0, z=1},
        --maxvel = {x=1, y=0, z=1},
        --minacc = {x=1, y=0, z=1},
        --maxacc = {x=1, y=0, z=1},
        minexptime = 1,
        maxexptime = 1,
        minsize = 1.0,
        maxsize = 1.5,
        collisiondetection = false,
        vertical = false,
        texture = texture_name,        
        glow = 14
    })
end

petz.do_sound_effect = function(dest, dest_name, soundfile)
    minetest.sound_play(soundfile, {dest = dest_name, gain = 0.4})
end