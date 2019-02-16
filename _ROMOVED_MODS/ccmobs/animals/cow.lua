--
--COW
--
minetest.register_node("ccmobs2:cow_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.25, -0.4375, 0.3125, 0.4375, 0.25},
			{-0.25, -0.5, 0, -0.0625, -0.25, 0.1875},
			{0.0625, -0.5, 0, 0.25, -0.25, 0.1875},
			{-0.25, -0.5, -0.375, -0.0625, -0.25, -0.1875},
			{0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875},
			{-0.3125, 0.3125, 0.25, 0.3125, 0.375, 0.375},
			{-0.1875, 0.0625, -0.1875, 0.1875, 0.375, 0.25},
			{-0.0625, -0.1875, 0.0625, 0.0625, -0.125, 0.25},
			{-0.1875, 0.0625, 0.25, 0.1875, 0.3125, 0.5},
			{-0.0625, -0.0625, -0.5, 0.0625, 0.3125, -0.4375},
			{-0.1875, 0.125, 0.25, 0.1875, 0.4375, 0.4375},
			{-0.0625, 0, 0.1875, 0.0625, 0.0625, 0.4375},
			{-0.0625, -0.0625, 0.1875, 0.0625, 0, 0.375},
			{0.0625, 0.4375, 0.3125, 0.125, 0.5, 0.375},
			{-0.125, 0.4375, 0.3125, -0.0625, 0.5, 0.375},
			{-0.0625, -0.125, 0.1875, 0.0625, -0.0625, 0.3125},
		},
	},
	tiles = {"ccmobs2_cow_top.png", "ccmobs2_cow_bottom.png", "ccmobs2_cow_right_side.png",
    "ccmobs2_cow_left_side.png", "ccmobs2_cow_front.png", "ccmobs2_cow_back.png"},
    groups = {not_in_creative_inventory = 1},
})

minetest.register_node("ccmobs2:cow_block2", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
            {-0.3125, -0.25, -0.4375, 0.3125, 0.3125, 0.1875},
            {-0.1875, -0.0625, 0.1875, 0.1875, 0.1875, 0.25},
            {-0.1875, -0.125, 0.25, 0.1875, 0.125, 0.5625},
            {-0.3125, 0.125, 0.25, 0.3125, 0.1875, 0.375},
            {-0.1875, -0.1875, 0.25, 0.1875, 0.1875, 0.4375},
            {-0.125, -0.25, 0.1875, 0.125, 0.1875, 0.3125},
            {-0.25, -0.5, -0.0625, -0.0625, -0.1875, 0.125},
            {0.0625, -0.5, -0.0625, 0.25, -0.0625, 0.125},
            {-0.25, -0.5, -0.375, -0.0625, -0.1875, -0.1875},
            {0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875},
            {-0.0276272, -0.1875, -0.478997, 0.0376734, 0.1875, -0.4375},
            {-0.125, 0.1875, 0.1875, 0.125, 0.25, 0.375}
		},
	},
	tiles = {"ccmobs2_cow_top2.png", "ccmobs2_cow_bottom2.png", "ccmobs2_cow_right_side2.png",
    "ccmobs2_cow_left_side2.png", "ccmobs2_cow_front2.png", "ccmobs2_cow_back2.png"},
    groups = {not_in_creative_inventory = 1},
})

mobs:register_mob("ccmobs2:cow", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	attack_npcs = false,
	reach = 2,
	damage = 4,
	hp_min = 5,
	hp_max = 20,
	armor = 200,
	collisionbox = {-0.9, -1, -1, 0.9, 0.9, 1},
	visual = "wielditem",
	visual_size = {x = 1.355, y = 1.355},
	textures = {
        {"ccmobs2:cow_block"},
        {"ccmobs2:cow_block2"},
    },
	makes_footstep_sound = false,
	walk_velocity = 0.25,
    run_velocity = 0.5,
	jump = false,
    pushable = true,
	drops = {
		{name = "ccmobs2:meat_raw",
		chance = 1,
		min = 1,
		max = 3,},
        {name = "ccmobs2:leather",
		chance = 1,
		min = 1,
		max = 2,}
		},
	drawtype = "front",
	water_damage = 2,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "ccmobs2_cow",
	},
    follow = {"farming:wheat", "default:grass_1"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {
		{"group:grass", "air", 0},
		{"default:dirt_with_grass", "default:dirt", -1}
	},
	fear_height = 2,
    on_rightclick = function(self, clicker)

    -- feed or tame
    if mobs:feed_tame(self, clicker, 8, true, true) then

        -- if fed 7x wheat or grass then cow can be milked again
        if self.food and self.food > 6 then
            self.gotten = false
        end

        return
    end

    if mobs:protect(self, clicker) then return end
    if mobs:capture_mob(self, clicker, 99, nil, "ccmobs2:cow") then return end

    local tool = clicker:get_wielded_item()
    local name = clicker:get_player_name()

    -- milk cow with empty bucket
    if tool:get_name() == "bucket:bucket_empty" then

        --if self.gotten == true
        if self.child == true then
            return
        end

        if self.gotten == true then
            minetest.sound_play("ccmobs2_cow",{pos=pos, max_hear_distance=3, gain=0.5, loop=false})
            return
        end

        local inv = clicker:get_inventory()

        tool:take_item()
        clicker:set_wielded_item(tool)

        if inv:room_for_item("main", {name = "ccmobs2:bucket_milk"}) then
            clicker:get_inventory():add_item("main", "ccmobs2:bucket_milk")
        else
            local pos = self.object:get_pos()
            pos.y = pos.y + 0.5
            minetest.add_item(pos, {name = "ccmobs2:bucket_milk"})
        end

            self.gotten = true -- milked

            return
        end
    end,
	on_replace = function(self, pos, oldnode, newnode)

		self.food = (self.food or 0) + 1

		-- if cow replaces 6x grass then it can be milked again
		if self.food >= 6 then
			self.food = 0
			self.gotten = false
		end
	end,
})
