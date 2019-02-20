
--
--Rockmonster
--
minetest.register_node("ccmobs2:rockmonster_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{0.0625, -0.5, -0.125, 0.3125, -0.375, 0.125},
			{-0.3125, -0.5, -0.125, -0.0625, -0.375, 0.125},
			{0.0625, -0.375, -0.125, 0.25, -0.1875, 0.0625},
			{-0.25, -0.375, -0.125, -0.0625, -0.1875, 0.0625},
			{-0.25, -0.254703, -0.125, 0.25, 0.25, 0.0625},
			{-0.3125, -0.1875, -0.1875, 0.3125, 0.125, 0.125},
			{-0.125, 0.25, -0, 0.125, 0.375, 0.099219},
			{-0.125, 0.1875, -0.1875, 0.125, 0.4375, 0.0625},
			{-0.1875, 0.4375, -0.1875, 0.1875, 0.5, 0.157427},
			{0.125, 0.25, -0.1875, 0.1875, 0.5, 0.125},
			{-0.1875, 0.25, -0.1875, -0.125, 0.5, 0.125},
			{0.25, 0.0625, -0.1875, 0.5, 0.3125, 0.0625},
			{-0.5, 0.0625, -0.1875, -0.25, 0.3125, 0.0625},
			{0.333452, -0.25, -0.125, 0.474025, 0.0625, -0},
			{-0.474025, -0.25, -0.125, -0.339991, 0.0625, -0},
			{-0.3125, 0.0625, -0.207698, 0.3125, 0.235111, 0.154782},
			{-0.292365, -0.1875, -0.198212, 0.292365, 0.125, 0.215763},
		},
	},
	tiles = {"ccmobs2_rockmonster_top.png", "ccmobs2_rockmonster_bottom.png", "ccmobs2_rockmonster_right_side.png",
    "ccmobs2_rockmonster_left_side.png", "ccmobs2_rockmonster_front.png", "ccmobs2_rockmonster_back.png"},
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("ccmobs2:rockmonster", {
	type = "monster",
    passive = false,
	damage = 4,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 12, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	reach = 3,
	shoot_interval = 2.2,
	arrow = "ccmobs2:boulder",
	shoot_offset = 1,
	pathfinding = false,
	hp_min = 12,
	hp_max = 35,
	armor = 80,
	collisionbox = {-1.2, -1.7, -1.2, 1.2, 1.7, 1.2},
	visual = "wielditem",
	textures = {"ccmobs2:rockmonster_block"},
	visual_size = {x = 2.0, y = 2.265},
    blood_texture = "default_clay_lump.png",
	makes_footstep_sound = true,
    sounds = {
        random = "ccmobs2_rockmonster",
        shoot_attack = "ccmobs2_rockmonster",
        shoot_explode = "default_place_node_hard",
	},
	walk_velocity = 0.5,
	run_velocity = 1.25,
	jump_height = 0,
	stepheight = 1.1,
	floats = 0,
	view_range = 15,
	drops = {
		{name = "default:cobble", chance = 1, min = 0, max = 2},
		{name = "default:coal_lump", chance = 3, min = 0, max = 2},
		{name = "default:stone", chance = 5, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0.5,
    fall_damage = 1,
    fear_height = 5,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
        shoot_start = 36,
		shoot_end = 48,
	},
})

-- boulder (weapon)
mobs:register_arrow("ccmobs2:boulder", {
	visual = "sprite",
	visual_size = {x = 1.5, y = 1.5},
	textures = {"ccmobs2_boulder.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 15,

	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_node = function(self, pos, node)
		self.object:remove()
	end
})
