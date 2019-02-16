--
--POLAR BEAR
--

zmobs = {}

minetest.register_node("zmobs:polar_bear_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.375, -0.5, 0.25, 0.125, 0.1875}, -- NodeBox1
			{-0.25, -0.5, -0.5, -0.0625, -0.375, -0.3125}, -- NodeBox2
			{0.0625, -0.5, -0.5, 0.25, -0.375, -0.3125}, -- NodeBox3
			{0.0625, -0.5, 0, 0.25, -0.375, 0.1875}, -- NodeBox4
			{0.0625, -0.5, 0, 0.25, -0.4375, 0.25}, -- NodeBox5
			{-0.25, -0.5, 0, -0.0625, -0.4375, 0.25}, -- NodeBox6
			{-0.25, -0.5, 0, -0.0625, -0.375, 0.1875}, -- NodeBox7
			{-0.25, -0.5, -0.5, -0.0625, -0.4375, -0.25}, -- NodeBox8
			{0.0625, -0.5, -0.5, 0.25, -0.4375, -0.25}, -- NodeBox9
			{-0.155, -0.0625, 0.1875, 0.155, 0.1875, 0.375}, -- NodeBox10
			{-0.0925, -0.0625, 0.375, 0.0925, 0.0625, 0.46}, -- NodeBox11
			{-0.125, 0.1875, 0.25, -0.0625, 0.25, 0.3125}, -- NodeBox12
			{0.0625, 0.1875, 0.25, 0.125, 0.25, 0.3125}, -- NodeBox13
		},
	},
	tiles = {"zmobs_polar_bear_top.png", "zmobs_polar_bear_bottom.png", "zmobs_polar_bear_right.png",
    "zmobs_polar_bear_left.png", "zmobs_polar_bear_front.png", "zmobs_polar_bear_back.png"},
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("zmobs:polar_bear", {
	type = "monster",
	attack_type = "dogfight",
	damage = 8,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	collisionbox = {-0.525, -0.585, -0.525, 0.525, 0.325, 0.525},
	visual = "wielditem",
	visual_size = {x=0.75, y=0.75},
	textures = {"zmobs:polar_bear_block"},
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
	drawtype = "front",
	water_damage = 2,
	lava_damage = 6,
	light_damage = 0,
    --sounds = {
		--random = "zmobs_sheep",
	--},
    animation = {
			speed_normal = 15,
			speed_run = 15,
			stand_start = 0,
			stand_end = 80,
			walk_start = 81,
			walk_end = 100,
		},
    view_range = 4,
    replace_rate = 10,
    fear_height = 3,
    })
