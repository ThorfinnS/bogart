
--
--dirtmonster
--

ccmobs2 = {}

minetest.register_node("ccmobs2:dirtmonster_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.0625, -0.3125, 0.3125, 0.5, 0.3125}, 
			{-0.125, -0.5, -0.125, 0.125, 0, 0.125}, 
			{-0.25, -0.25, -0.0625, 0.25, 0, 0.0625}, 
			--{-0.1875, -0.4375, -0.1875, 0.1875, -0.125, 0.125},
		},
	},
	tiles = {"default_grass.png", "default_dirt.png", "ccmobs2_dirtmonster_sides.png",
    "ccmobs2_dirtmonster_sides.png", "ccmobs2_dirtmonster_front.png", "ccmobs2_dirtmonster_sides.png"},
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("ccmobs2:dirtmonster", {
	type = "monster",
    --docile_by_day = true,
	damage = 0.5,
	attack_type = "shoot",
	reach = 1,
	shoot_interval = 3.5,
	arrow = "ccmobs2:dirt_clump",
	shoot_offset = 2.5,
    group_attack = true,
    pathfinding = true,
	hp_min = 2,
	hp_max = 4,
	armor = 300,
	collisionbox = {-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125},
	visual = "wielditem",
	textures = {"ccmobs2:dirtmonster_block"},
	visual_size = {x = 0.65, y = 0.65},
    blood_texture = "default_dirt.png",
	makes_footstep_sound = false,
    sounds = {
        random = "ccmobs2_dirtmonster",
        shoot_attack = "ccmobs2_dirtmonster",
	},
	walk_velocity = 0.05,
	run_velocity = 0.25,
    runaway = true,
    pushable = true,
	jump = false,
	jump_height = 0,
	stepheight = 0,
	floats = 0,
	view_range = 15,
	drops = {
		{name = "default:dirt", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    fall_damage = 1,
    fear_height = 5,
	animation = {
		speed_normal = 0.5,
		speed_run = 0.5,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
        shoot_start = 10,
		shoot_end = 30,
	},
    on_rightclick = function(self, clicker)
		ccmobs2:capture_mob(self, clicker, "ccmobs2:dirtmonster")
	end,
})

-- dirt clump (weapon)
mobs:register_arrow("ccmobs2:dirt_clump", {
	visual = "sprite",
	visual_size = {x = 0.25, y = 0.25},
	textures = {"ccmobs2_dirt_clump.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 20,

	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_node = function(self, pos, node)
		self.object:remove()
	end
})
