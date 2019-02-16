--
--Goat
--
minetest.register_node("ccmobs2:goat_block", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.209225, -0.25, -0.39438, 0.205956, 0.0625, 0.14237},
			{-0.1875, -0.5, -0.375, -0.0625, -0.25, -0.25},
			{0.0625, -0.5, -0.375, 0.1875, -0.25, -0.25},
			{-0.1875, -0.5, 0, -0.0625, -0.25, 0.125},
			{0.0625, -0.5, 0, 0.1875, -0.25, 0.125},
			{-0.0625, -0.125, -0.4375, 0.0625, 0, -0.375},
			{-0.0625, -0.125, 0.1875, 0.0625, -0, 0.4375},
			{-0.125, -0.125, 0.125, 0.125, 0.0625, 0.3125},
			{-0.125, -0.1875, 0.1875, 0.125, 0, 0.375},
			{-0.25, -0.0274816, 0.169995, 0.25, 0, 0.26807},
			{0.0625, 0.0625, 0.1875, 0.125, 0.125, 0.25},--
			{-0.125, 0.0625, 0.1875, -0.0625, 0.125, 0.25},--
			{-0.0625, -0.125, 0.125, 0.0625, 0.0185544, 0.375},
		},
	},
	tiles = {"ccmobs2_goat_top.png", "ccmobs2_goat_bottom.png", "ccmobs2_goat_right_side.png",
    "ccmobs2_goat_left_side.png", "ccmobs2_goat_front.png", "ccmobs2_goat_back.png"},
    groups = {not_in_creative_inventory = 1},
})



mobs:register_mob("ccmobs2:goat", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	attack_npcs = false,
	reach = 1,
	damage = 4,
	hp_min = 5,
	hp_max = 10,
    armor = 100,
	collisionbox = {-0.525, -0.6525, -0.525, 0.525, 0.325, 0.525},
	visual = "wielditem",
	visual_size = {x=0.85, y=0.85},
	textures = {"ccmobs2:goat_block"},
	makes_footstep_sound = false,
	walk_velocity = 0.3,
    run_velocity = 1,
	jump = true,
	jump_height = 6,
	pushable = true,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 1,
		max = 2,},
        {name = "mobs:leather",
		chance = 3,
		min = 1,
		max = 1,},
		},
	drawtype = "front",
	water_damage = 2,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "ccmobs2_goat",
	},
    follow = {"farming:wheat", "default:apple"},
	view_range = 10,
	replace_rate = 12,
	replace_what = {
		{"group:grass", "air", 0},
		{"group:flower", "air", 0},
	},
    on_rightclick = function(self, clicker)

    -- feed or tame
    if mobs:feed_tame(self, clicker, 8, true, true) then

        -- if fed 7x wheat or grass then goat can be milked again
        if self.food and self.food > 6 then
            self.gotten = false
        end

        return
    end

    if mobs:protect(self, clicker) then return end
    if mobs:capture_mob(self, clicker, 0, 5, 60, false, nil) then return end

    local tool = clicker:get_wielded_item()
    local name = clicker:get_player_name()

    -- milk goat with empty bucket
    if tool:get_name() == "bucket:bucket_empty" then

        --if self.gotten == true
        if self.child == true then
            return
        end

        if self.gotten == true then
            minetest.sound_play("ccmobs2_sheep_hurt",{pos=pos, max_hear_distance=3, gain=0.5, loop=false})
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

		-- if goat replaces 10x grass then it can be milked again
		if self.food >= 10 then
			self.food = 0
			self.gotten = false
		end
	end,
})
