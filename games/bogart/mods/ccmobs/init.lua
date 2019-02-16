--
-- kmobs 
-- License:MIT
--

local modname = "kmobs"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

kmobs = {}

--SPAWNING: [true --or-- false]
local COW_SPAWN = false
local DIRTMONSTER_SPAWN = false
local GOAT_SPAWN = false
local PIG_SPAWN = false
local ROCKMONSTER_SPAWN = false
local SHEEP_SPAWN = false
local TREEMONSTER_SPAWN = false
local KITTY_SPAWN = true


--mobs:register_spawn
if COW_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/animals/cow.lua")

    mobs:register_egg("kmobs:cow", "Cow", "kmobs_spawnegg_cow.png", 0)

    mobs:spawn({
        name = "kmobs:cow",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 100,
        chance = 2400, 
        min_height = 5,
        max_height = 100,
        day_toggle = true,
    })
end

if DIRTMONSTER_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/monsters/dirtmonster.lua")

    mobs:register_egg("kmobs:dirtmonster", "Dirt Monster", "kmobs_spawnegg_dirtmonster.png", 0)

    mobs:spawn({
        name = "kmobs:dirtmonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:flowers"},
        min_light = 1,
        max_light = 14,
        interval = 100,
        chance = 1000, 
        min_height = 10,
        max_height = 300,
    })
end

if GOAT_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/animals/goat.lua")

    mobs:register_egg("kmobs:goat", "Goat", "kmobs_spawnegg_goat.png", 0)

    mobs:spawn({
        name = "kmobs:goat",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 100,
        chance = 2800, 
        min_height = 200,
        max_height = 800,
        day_toggle = true,
    })
end

if PIG_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/animals/pig.lua")

    mobs:register_egg("kmobs:pig", "Pig", "kmobs_spawnegg_pig.png", 0)

    mobs:spawn({
        name = "kmobs:pig",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 100,
        chance = 2800, 
        min_height = 10,
        max_height = 80,
        day_toggle = true,
    })
end

if SHEEP_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/animals/sheep.lua")

    mobs:register_egg("kmobs:sheep", "Sheep", "kmobs_spawnegg_sheep.png", 0)

    mobs:spawn({
        name = "kmobs:sheep",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 100,
        chance = 1000, 
        min_height = 10,
        max_height = 100,
        day_toggle = true,
    })
end

if ROCKMONSTER_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/monsters/rockmonster.lua")

    mobs:register_egg("kmobs:rockmonster", "Rock Monster", "kmobs_spawnegg_rockmonster.png", 0)

    mobs:spawn({
        name = "kmobs:rockmonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:stone"},
        min_light = 3,
        max_light = 5,
        interval = 100,
        chance = 2800, 
        min_height = -100,
        max_height = 1200,
        day_toggle = false,
    })
end

if TREEMONSTER_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/monsters/treemonster.lua")

    mobs:register_egg("kmobs:treemonster", "Tree Monster", "kmobs_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "kmobs:treemonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:leaves"},
        min_light = 3,
        max_light = 5,
        interval = 90,
        chance = 900, 
        min_height = 10,
        max_height = 300,
        day_toggle = false,
    })
end

if KITTY_SPAWN then

    dofile(minetest.get_modpath("kmobs").."/animals/kitty.lua")

    mobs:register_egg("kmobs:kitty", S("Kitty"), "kmobs_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "kmobs:kitty",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:leaves"},
        min_light = 3,
        max_light = 5,
        interval = 90,
        chance = 900, 
        min_height = 1,
        max_height = 300,
        day_toggle = false,
    })
end

-- animal cage
minetest.register_craft({
	output = "kmobs:cage",
	recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"group:stick", "group:stick", "group:stick"}
	},
})

minetest.register_craftitem("kmobs:cage", {
	description = "Animal Cage",
	inventory_image = "kmobs_cage.png"
})

-- bucket of milk
minetest.register_craftitem("kmobs:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "kmobs_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})

-- capture critter (from Mobs_Redo API)
function kmobs:capture_mob(self, clicker, replacewith)

	local mobname = self.name

	if replacewith then
		mobname = replacewith
	end

	local name = clicker:get_player_name()
	local tool = clicker:get_wielded_item()

	if tool:get_name() ~= "kmobs:cage" then
		return false
	end

	if clicker:get_inventory():room_for_item("main", mobname) then

		if tool:get_name() == "kmobs:cage" then

			clicker:set_wielded_item(tool)

		end

			local new_stack = ItemStack(mobname)

			new_stack = ItemStack(replacewith)

			local inv = clicker:get_inventory()

			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(clicker:get_pos(), new_stack)
                
			end

			self.object:remove()

			self:mob_sound("default_place_node_hard")

            inv:remove_item("main", "kmobs:cage")

			return new_stack
        end
    end
