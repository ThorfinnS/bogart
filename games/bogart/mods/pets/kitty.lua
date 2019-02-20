--
--KITTY
--

minetest.register_node("pets:kitty_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.0625, -0.0625, -0.375, 0.125}, -- back_right_leg
			{-0.125, -0.5, -0.1875, -0.0625, -0.375, -0.125}, -- front_right_leg
			{0, -0.5, -0.1875, 0.0625, -0.375, -0.125}, -- front_left_leg
			{0, -0.5, 0.0625, 0.0625, -0.375, 0.125}, -- back_left_leg
			{-0.125, -0.375, -0.1875, 0.0625, -0.25, 0.125}, -- body
			{-0.125, -0.3125, -0.3125, 0.0625, -0.125, -0.125}, -- head
			{-0.0625, -0.3125, 0.125, 0.0, -0.25, 0.1875}, -- top_tail
			{-0.125, -0.125, -0.25, -0.0625, -0.0625, -0.1875}, -- right_ear
			{-0.0625, -0.375, 0.1875, 0.0, -0.3125, 0.3125}, -- bottom_tail
			{0, -0.125, -0.25, 0.0625, -0.0625, -0.1875}, -- left_ear
	},
	},
	tiles = {
		"pets_kitty_top.png",
		"pets_kitty_bottom.png",
		"pets_kitty_right.png",
		"pets_kitty_left.png",
		"pets_kitty_back.png",
		"pets_kitty_front.png"
	},
	paramtype = "light",
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("pets:kitty", {
	type = "animal",
	rotate = 180,
	damage = 8,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	--selectionbox = {-0.125, -0.5, -0.1875, 0.0625, 0.5, 0.125},
	visual = "wielditem",
	visual_size = {x=1.0, y=1.0},
	textures = {"pets:kitty_block"},
	makes_footstep_sound = false,
	walk_velocity = 0.75,
    run_velocity = 1,
    runaway = true,
    pushable = true,
	jump = true,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 1,
		max = 1,},
		},
	water_damage = 2,
	lava_damage = 6,
	light_damage = 0,
    sounds = {
		random = "pets_kitty",
	},
    animation = {
			speed_normal = 15,
			speed_run = 15,
			stand_start = 0,
			stand_end = 80,
			walk_start = 81,
			walk_end = 100,
		},
    view_range = 4,
    fear_height = 3,
    })
