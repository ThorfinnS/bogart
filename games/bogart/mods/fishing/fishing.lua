
local modpath, S = ...

fishing = {
	isfishing= false,
	timeout= 120.0,
	fishes ={},
	get_nodehabitat = function(pointed_thing)
		local node = minetest.get_node(pointed_thing.under).name	
		local node_habitat
		if node == "default:water_source" then
			node_habitat = "sea"
		elseif node == "default:river_water_source" then
			node_habitat = "river"
		else
			node_habitat = nil
		end
		return node_habitat
	end,
	registerfish = function(fish)
		--habitats are "river", "sea" or "clutter"
		fishing.fishes[#fishing.fishes+1] = {fish.name, fish.habitat}
		minetest.register_craftitem(fish.name, {
			description = S(fish.description),
			inventory_image = fish.inventory_image,
			wield_image = fish.wield_image,
			groups = {food_fish_raw = 1, flammable = 3},
			on_use = minetest.item_eat(fish.hp_eat),
		})
	end,
	--custom function to get only array values of tables, not keys
	arrayvalues = function(arr)
    	local i = 0
    	return function() i = i + 1; return arr[i] end
	end,
}

-- Register fishes
fishing.registerfish{name="fishing:fish_raw", description="Raw Fish", habitat= "river", inventory_image="fishing_fish_raw.png", wield_image="fishing_fish_raw.png", hp_eat=2}
fishing.registerfish{name="fishing:salmon", description="Salmon", habitat= "river", inventory_image="fishing_salmon.png", wield_image="fishing_salmon.png", hp_eat=3}
fishing.registerfish{name="fishing:pufferfish", description="Pufferfish", habitat= "sea", inventory_image="fishing_pufferfish.png", wield_image="fishing_pufferfish.png", hp_eat=-5}
fishing.registerfish{name="fishing:clownfish", description="Clownfish", habitat= "sea", inventory_image="fishing_clownfish.png", wield_image="fishing_clownfish.png", hp_eat=1}
fishing.registerfish{name="fishing:diamond_ring", description="Diamond Ring", habitat= "clutter", inventory_image="fishing_diamond_ring.png", wield_image="fishingfishing_diamond_ring.png", hp_eat=1}

minetest.register_craft({
    type = "shaped",
    output = "fishing:diamond_ring",
    recipe = {
        {"", "", ""},
        {"", "default:diamond", ""},
       	{"", "default:steel_ingot", ""},
    }
})

minetest.register_craft({
	type = "cooking",
	output = "default:diamond",
	recipe = "fishing:diamond_ring",
	cooktime = 3,
})

-- Cooked Fish
minetest.register_craftitem("fishing:fish_cooked", {
	description = S("Cooked Fish"),
	inventory_image = "fishing_fish_cooked.png",
	wield_image = "fishing_fish_cooked.png",
	groups = {food_fish = 1, flammable = 3},
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "cooking",
	output = "fishing:fish_cooked",
	recipe = "fishing:fish_raw",
	cooktime = 2,
})

-- Worm
minetest.register_craftitem("fishing:worm", {
	description = S("Worm"),
	inventory_image = "fishing_worm.png",
	wield_image = "fishing_worm.png",
})

-- Fishing Rod
minetest.register_craftitem("fishing:fishing_rod", {
	description = S("Fishing Rod"),
	inventory_image = "fishing_rod.png",
	wield_image = "fishing_rod.png",
})

minetest.register_craft({
	output = "fishing:fishing_rod",
	recipe = {
			{"","","default:stick"},
			{"", "default:stick", "farming:string"},
			{"default:stick", "", "farming:string"},
		}
})

-- Sift through 2 Dirt Blocks to find Worm
minetest.register_craft({
	output = "fishing:worm",
	recipe = {
		{"default:dirt","default:dirt"},
	}
})

local function fishing_rod_node_timer(pos, elapsed)
	
end

-- Fishing Rod (Baited)
minetest.register_craftitem("fishing:fishing_rod_baited", {
	description = S("Baited Fishing Rod"),
	inventory_image = "fishing_rod_baited.png",
	wield_image = "fishing_rod_wield.png",
	--wield_keyframes = {{x = 0, y = 0, z = 20, duration = 5}},
	stack_max = 1,
	liquids_pointable = true,
	on_timer = fishing_rod_node_timer,
	on_use = function (itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		--local pos= minetest.get_pointed_thing_position(pointed_thing, above)		

		--if fishing.isfishing == false and node_habitat ~= nil then
			--fishing.isfishing = true
			--itemstack.wield_image = "fishing_rod_baited.png"
			--minetest.get_node_timer(pos):start(fishing.timeout)
		--else
			--fishing.isfishing = false			
			--wield_image = "fishing_rod_wield.png"
			--minetest.get_node_timer(pos):stop()
			--return
		--end

		local node_habitat = fishing.get_nodehabitat(pointed_thing)

		if (node_habitat ~= nil and math.random(1, 100) < 10) then
			--Search for fishes accordingly habitat
			local fish
			local fishesbyhabitat = {}
			for fish in fishing.arrayvalues(fishing.fishes) do
				if fish[2] == node_habitat then
					fishesbyhabitat[#fishesbyhabitat+1] = fish
				end
			end

			local fishedfish = fishesbyhabitat[math.random(1, #fishesbyhabitat)]

			local fishedfish_name = fishedfish[1]

			--minetest.chat_send_player("singleplayer", fishedfish_name)

			--local chance_diamond_ring= math.random(1, 100)

			--if chance_diamond_ring < 2 then
				--fishtype= fishing.fish[5]
			--end

			local inv = user:get_inventory()

			if inv:room_for_item("main", {name = fishedfish_name}) then

				local user_pos = user:getpos()
				user_pos.y = user_pos.y+0.5

				local fish_pos =  minetest.get_pointed_thing_position(pointed_thing, above)

				local vel = vector.multiply(vector.subtract(user_pos, fish_pos), 1)
				vel.y = vel.y + 0.6

				minetest.add_particlespawner({
					amount = 5,
					time = 1,
					minpos = fish_pos,
					maxpos = fish_pos,
					minvel = {x=1, y=1, z=0},
					maxvel = {x=1, y=1, z=0},
					minacc = {x=1, y=1, z=1},
					maxacc = {x=1, y=1, z=1},
					minexptime = 1,
					maxexptime = 1,
					minsize = 1,
					maxsize = 1,
					collisiondetection = false,
					vertical = false,
					texture = "default_water.png",
					playername = "singleplayer"
				})

				local fish_inv_img = minetest.registered_craftitems[fishedfish_name].inventory_image

				minetest.add_particle({
					pos = fish_pos,
					velocity = vel,
					acceleration = {x=1, y=1, z=1},
					expirationtime = 1,
					size = 2,
					collisiondetection = false,
					vertical = false,
					texture = fish_inv_img,
					playername = "singleplayer"
				})

				minetest.sound_play("fishing")
				
				inv:add_item("main", {name = fishedfish_name})

				return ItemStack("fishing:fishing_rod")
			else
				minetest.chat_send_player(user:get_player_name(),
					S("Inventory full, Fish Got Away!"))
			end
		end
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:fishing_rod_baited",
	recipe = {"fishing:fishing_rod", "fishing:worm"},
})
