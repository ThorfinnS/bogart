--
--PUPPY
--
local S, type_model, visual, visual_size, mesh, rotate, textures, collisionbox, follow, food = ...

local pet_name= "puppy"
local scale_puppy = 1.5

if type_model == "cubic" then
	local node_name = "petz:"..pet_name.."_block"
	fixed = {
		{-0.125, -0.5, 0.0625, -0.0625, -0.375, 0.125}, -- back_right_leg
		{-0.125, -0.5, -0.125, -0.0625, -0.375, -0.0625}, -- front_right_leg
		{0, -0.5, -0.125, 0.0625, -0.375, -0.0625}, -- front_left_leg
		{0, -0.5, 0.0625, 0.0625, -0.375, 0.125}, -- back_left_leg
		{-0.125, -0.375, -0.125, 0.0625, -0.25, 0.125}, -- body
		{-0.125, -0.375, -0.25, 0.0625, -0.1875, -0.0625001}, -- head
		{-0.0625, -0.3125, 0.125, 1.11759e-08, -0.25, 0.25}, -- tail
		{-0.125, -0.1875, -0.1875, -0.0625, -0.125, -0.125}, -- right_ear
		{0, -0.1875, -0.1875, 0.0625, -0.125, -0.125}, -- left_ear
		{-0.125, -0.375, -0.3125, 0.0625, -0.3125, -0.25}, -- snout
		{-0.0625, -0.4375, -0.25, 3.72529e-09, -0.375, -0.1875}, -- tongue
	}
	tiles = {
		"petz_puppy_top.png",
		"petz_puppy_bottom.png",
		"petz_puppy_right.png",
		"petz_puppy_left.png",
		"petz_puppy_back.png",
		"petz_puppy_front.png"
	}
	petz.register_cubic(node_name, fixed, tiles)		
	textures= {"petz:puppy_block"}
	collisionbox = {-0.35, -0.75*scale_puppy, -0.28, 0.35, -0.125, 0.28}
else
	mesh = 'petz_puppy.b3d'	
	textures= {{"petz_puppy.png"}, {"petz_puppy2.png"}, {"petz_puppy3.png"}}
	collisionbox = {-0.35, -0.75*scale_puppy, -0.28, 0.35, -0.3125, 0.28}
end

mobs:register_mob("petz:"..pet_name, {
	type = "animal",
	rotate = rotate,
	damage = 8,
    hp_min = 4,
    hp_max = 8,
    affinity = 100,
    armor = 200,
	visual = visual,
	visual_size = {x=visual_size.x*scale_puppy, y=visual_size.y*scale_puppy},
	mesh = mesh,
	textures = textures,
	collisionbox = collisionbox,
	makes_footstep_sound = false,
	walk_velocity = 0.75,
    run_velocity = 1,
    runaway = true,
    pushable = true,
	jump = true,
	floats = true,
	--fly = true,
	--fly_in = "default:water_source",
	follow = follow,	
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 1,
		max = 1,},
		},
	water_damage = 0,
	lava_damage = 6,
	light_damage = 0,
    sounds = {
		random = "petz_puppy_bark",
	},
    animation = {
    	speed_normal = 15, walk_start = 1, walk_end = 12,
    	speed_run = 25, run_start = 13, run_end = 25,
    	stand_start = 26, stand_end = 46,		
    	stand2_start = 47, stand2_end = 59,	
    	stand3_start = 60, stand3_end = 81,	
    	stand4_start = 82, stand4_end = 94,	
		},
    view_range = 4,
    fear_height = 3,
    do_punch = function (self, hitter, time_from_last_punch, tool_capabilities, direction)
    	petz.do_punch(self, hitter, time_from_last_punch, tool_capabilities, direction)
	end,
    on_die = function(self, pos)
    	petz.on_die(self, pos)
    end,
	on_rightclick = function(self, clicker)
		petz.on_rightclick(self, clicker, pet_name)
	end,
})