--
--KITTY
--

local TYPE_MODEL, Visual, VisualSize, Mesh, Rotate, Textures, CollisionBox = ...

if TYPE_MODEL == "cubic" then
	minetest.register_node("petz:kitty_block", {
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
			"petz_kitty_top.png",
			"petz_kitty_bottom.png",
			"petz_kitty_right.png",
			"petz_kitty_left.png",
			"petz_kitty_back.png",
			"petz_kitty_front.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
    	groups = {not_in_creative_inventory = 1},
	})		
	Textures= {"petz:kitty_block"}
	CollisionBox = {-0.35, -0.75, -0.28, 0.35, -0.125, 0.28}
else
	Mesh = 'petz_kitty.b3d'	
	Textures= {"petz_kitty.png"}
	CollisionBox = {-0.35, -0.5, -0.28, 0.35, -0.125, 0.28}
end

mobs:register_mob("petz:kitty", {
	type = "animal",
	rotate = Rotate,
	damage = 8,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	visual = Visual,
	visual_size = VisualSize,
	mesh = Mesh,
	textures = Textures,
	collisionbox = CollisionBox,
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
		random = "petz_kitty",
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
