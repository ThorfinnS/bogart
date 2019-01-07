--
--SHEEP
--
minetest.register_node("ccmobs2:sheep_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.375, -0.4375, 0.3125, 0.1875, 0.1875},
			{-0.1875, -0.25, 0.125, 0.1875, 0.0625, 0.375},
			{-0.25, -0.0625, 0.1875, 0.25, 0.06, 0.3125},
			{-0.125, -0.3125, 0.3125, 0.125, 0.08995, 0.5},
			{0.0625, -0.5, -0.0625, 0.25, -0.375, 0.125},
			{-0.25, -0.5, -0.0625, -0.0625, -0.3125, 0.125},
			{0.0625, -0.5, -0.375, 0.25, -0.3125, -0.1875},
			{-0.25, -0.5, -0.375, -0.0625, -0.3125, -0.1875},
			{-0.0625, -0.1875, -0.5, 0.0625, 0.0625, -0.4375},
		},
	},
	tiles = {"ccmobs2_sheep_top.png", "ccmobs2_sheep_bottom.png", "ccmobs2_sheep_right_side.png",
    "ccmobs2_sheep_left_side.png", "ccmobs2_sheep_front.png", "ccmobs2_sheep_back.png"},
    groups = {not_in_creative_inventory = 1},
})

minetest.register_node("ccmobs2:sheep_shaved", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.35225, -0.375, 0.25, 0.125, 0.1875},
			{-0.1875, -0.207206, 0.125, 0.1875, 0.0207206, 0.375},
			{-0.25, -0.0625, 0.1875, 0.25, 0.06, 0.3125},
			{-0.125, -0.3125, 0.3125, 0.125, 0.08995, 0.5},
			{-0.0625, -0.1875, -0.4375, 0.0625, 0.0625, -0.375},
			{-0.25, -0.5, -0.375, -0.0625, -0.25, -0.1875},
			{0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875},
			{-0.25, -0.5, -0.0625, -0.0625, -0.25, 0.125},
			{0.0625, -0.5, -0.0625, 0.25, -0.25, 0.125},
		},
	},
	tiles = {"ccmobs2_sheep_shaved_top.png", "ccmobs2_sheep_bottom.png", "ccmobs2_sheep_shaved_right_side.png",
    "ccmobs2_sheep_shaved_left_side.png", "ccmobs2_sheep_shaved_front.png", "ccmobs2_sheep_shaved_back.png"},
    groups = {not_in_creative_inventory = 1},
})


mobs:register_mob("ccmobs2:sheep", {
	type = "animal",
	passive = true,
    hp_min = 4,
    hp_max = 8,
    armor = 200,
	collisionbox = {-0.525, -0.585, -0.525, 0.525, 0.325, 0.525},
	visual = "wielditem",
	visual_size = {x=0.75, y=0.75},
	textures = {"ccmobs2:sheep_block"},
    --gotten_texture = {"ccmobs2:sheep_shaved"},
	makes_footstep_sound = false,
	walk_velocity = 0.1,
    run_velocity = 0.75,
    runaway = true,
    pushable = true,
	jump = false,
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
    sounds = {
		random = "ccmobs2_sheep",
	},
    animation = {
			speed_normal = 15,
			speed_run = 15,
			stand_start = 0,
			stand_end = 80,
			walk_start = 81,
			walk_end = 100,
		},
    follow = {"farming:wheat", "default:grass_1"},
    view_range = 4,
    replace_rate = 10,
    replace_what = {
        {"group:grass", "air", -1},
        {"default:dirt_with_grass", "default:dirt", -2}
    },
    fear_height = 3,
    on_replace = function(self, pos, oldnode, newnode)

        self.food = (self.food or 0) + 1

        -- if sheep replaces 8x grass then it regrows wool
        if self.food >= 8 then

            self.food = 0
            self.gotten = false

            self.object:set_properties({
                textures = {"ccmobs2:sheep_block"},
                })
        end
    end,
    on_rightclick = function(self, clicker)
    tool = clicker:get_wielded_item():get_name()

        --are we feeding?
        if mobs:feed_tame(self, clicker, 8, true, true) then

            --if fed 7x grass or wheat then sheep regrows wool
            if self.food and self.food > 6 then

                self.gotten = false

                self.object:set_properties({
                    textures = {"ccmobs2:sheep_block"},
                })
            end

            return
        end

    
		if tool == "mobs:shears" and
            clicker:get_inventory() and not self.empty then
			self.empty = true
				clicker:get_inventory():add_item("main", "wool:white")
                minetest.sound_play("ccmobs2_sheep_hurt",{pos=pos, max_hear_distance=3, gain=0.5, loop=false})
				self.object:set_properties({
					textures = {"ccmobs2:sheep_shaved"},
				})
		end
    end
    })
