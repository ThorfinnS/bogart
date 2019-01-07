--
--PIG
--
minetest.register_node("ccmobs2:pig_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.4375, 0.3125, 0.125, 0.1875},
			{0.0625, -0.5, -0.375, 0.25, -0.375, -0.1875},
			{-0.25, -0.5, -0.375, -0.0625, -0.375, -0.1875},
			{0.0625, -0.5, -0.0625, 0.25, -0.375, 0.125},
			{-0.25, -0.5, -0.0625, -0.0625, -0.375, 0.125},
			{-0.375, -0.0351278, 0.1875, 0.375, 0, 0.3125},
			{-0.1875, -0.3125, 0.375, 0.1875, -0.0625, 0.5},
			{-0.25, -0.375, 0.125, 0.25, 0.0625, 0.375},
			{-0.0625, 0, -0.471661, 0.0625, 0.0625, -0.4375},
			{0.0625, -0.125, -0.471661, 0.125, 0, -0.4375},
			{0, -0.1875, -0.471661, 0.0625, -0.125, -0.4375},
		},
	},
	tiles = {"ccmobs2_pig_top.png", "ccmobs2_pig_bottom.png", "ccmobs2_pig_right_side.png",
    "ccmobs2_pig_left_side.png", "ccmobs2_pig_front.png", "ccmobs2_pig_back.png"},
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("ccmobs2:pig", {
	type = "animal",
	passive = true,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	collisionbox = {-0.25, -0.3525, -0.35, 0.25, 0.1, 0.35},
	visual = "wielditem",
	visual_size = {x = 0.45, y = 0.45},
	textures = {"ccmobs2:pig_block"},
	makes_footstep_sound = false,
	walk_velocity = 0.45,
    run_velocity = 1.25,
    runaway = true,
    jump = true,
    fear_height = 2,
	drops = {
		{name = "ccmobs2:pork_raw",
		chance = 1,
		min = 1,
		max = 2,},
		},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 6,
	light_damage = 0,
    sounds = {
		random = "ccmobs2_pig",
	},
    follow = {"default:apple"},
    view_range = 5,
})

-- raw porkchop
minetest.register_craftitem("ccmobs2:pork_raw", {
	description = "Raw Porkchop",
	inventory_image = "ccmobs2_pork_raw.png",
	on_use = minetest.item_eat(4),
})

-- cooked porkchop
minetest.register_craftitem("ccmobs2:pork_cooked", {
	description = "Cooked Porkchop",
	inventory_image = "ccmobs2_pork_cooked.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "ccmobs2:pork_cooked",
	recipe = "ccmobs2:pork_raw",
	cooktime = 5,
})
