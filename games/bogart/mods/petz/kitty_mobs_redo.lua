--
--KITTY
--
local S, form_pet_orders, type_model, visual, visual_size, mesh, rotate, textures, collisionbox, follow, food = ...

local pet_name= "kitty"

if type_model == "cubic" then
	local node_name = "petz:"..pet_name.."_block"
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
	}
	tiles = {
		"petz_kitty_top.png",
		"petz_kitty_bottom.png",
		"petz_kitty_right.png",
		"petz_kitty_left.png",
		"petz_kitty_back.png",
		"petz_kitty_front.png"
	}
	petz.register_cubic(node_name, fixed, tiles)		
	textures= {"petz:kitty_block"}
	collisionbox = {-0.35, -0.75, -0.28, 0.35, -0.125, 0.28}
else
	mesh = 'petz_kitty.b3d'	
	textures= {{"petz_kitty.png"}, {"petz_kitty2.png"}, {"petz_kitty3.png"}}
	collisionbox = {-0.35, -0.5, -0.28, 0.35, -0.125, 0.28}
end

mobs:register_mob("petz:"..pet_name, {
	type = "animal",
	rotate = rotate,
	damage = 8,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	visual = visual,
	visual_size = visual_size,
	mesh = mesh,
	textures = textures,
	collisionbox = collisionbox,
	makes_footstep_sound = false,
	walk_velocity = 0.75,
    run_velocity = 1,
    runaway = true,
    pushable = true,
	jump = true,
	follow = follow,	
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
		random = "petz_kitty_meow.ogg",
	},
    animation = {
    	speed_normal = 15, walk_start = 1, walk_end = 12,
    	speed_run = 25, run_start = 13, run_end = 25,
    	stand_start = 26, stand_end = 41,		
    	stand2_start = 42, stand2_end = 54,	
    	stand3_start = 55, stand3_end = 76,	
		},
    view_range = 4,
    fear_height = 3,
	on_rightclick = function(self, clicker)
		if not(clicker:is_player()) then
			return false
		end
		local player_name = clicker:get_player_name()
		if (self.owner ~= player_name) then
			return
		end
		local wielded_item = clicker:get_wielded_item()
		if wielded_item:get_name() == food then
			if self.health < self.hp_max then
				self.health = self.health + 2
				-- Decrease eat
				local inv = clicker:get_inventory()
				local count = wielded_item:get_count()
				count = count - 1
				if count >= 0 then
					wielded_item:set_count(count)
					local wielded_index = clicker:get_wield_index()
					local wielded_list_name = clicker:get_wield_list()
					inv:set_stack(wielded_list_name, wielded_index, wielded_item)
					--brewing.magic_sound("to_player", clicker, "brewing_eat")
				end
			else
				--brewing.magic_sound("to_player", clicker, "brewing_magic_failure")
			end
		else
			petz.pet = self
			minetest.show_formspec(player_name, "petz:form_orders", form_pet_orders)
		end
	end,
})