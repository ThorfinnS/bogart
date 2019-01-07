--
-- ccmobs2 
-- License:MIT
--


--SPAWNING: [true --or-- false]
local COW_SPAWN = true
local DIRTMONSTER_SPAWN = false
local GOAT_SPAWN = false
local PIG_SPAWN = false
local ROCKMONSTER_SPAWN = false
local SHEEP_SPAWN = true
local TREEMONSTER_SPAWN = false


--mobs:register_spawn
if COW_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/animals/cow.lua")

    mobs:register_egg("ccmobs2:cow", "Cow", "ccmobs2_spawnegg_cow.png", 0)

    mobs:spawn({
        name = "ccmobs2:cow",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 60,
        chance = 2000, 
        min_height = 5,
        max_height = 80,
        day_toggle = true,
    })
end

if DIRTMONSTER_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/monsters/dirtmonster.lua")

    mobs:register_egg("ccmobs2:dirtmonster", "Dirt Monster", "ccmobs2_spawnegg_dirtmonster.png", 0)

    mobs:spawn({
        name = "ccmobs2:dirtmonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:flowers"},
        min_light = 1,
        max_light = 14,
        interval = 60,
        chance = 900, 
        min_height = 10,
        max_height = 300,
    })
end

if GOAT_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/animals/goat.lua")

    mobs:register_egg("ccmobs2:goat", "Goat", "ccmobs2_spawnegg_goat.png", 0)

    mobs:spawn({
        name = "ccmobs2:goat",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 100,
        chance = 1800, 
        min_height = 200,
        max_height = 800,
        day_toggle = true,
    })
end

if PIG_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/animals/pig.lua")

    mobs:register_egg("ccmobs2:pig", "Pig", "ccmobs2_spawnegg_pig.png", 0)

    mobs:spawn({
        name = "ccmobs2:pig",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 60,
        chance = 2000, 
        min_height = 5,
        max_height = 80,
        day_toggle = true,
    })
end

if SHEEP_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/animals/sheep.lua")

    mobs:register_egg("ccmobs2:sheep", "Sheep", "ccmobs2_spawnegg_sheep.png", 0)

    mobs:spawn({
        name = "ccmobs2:sheep",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:grass"},
        min_light = 14,
        interval = 60,
        chance = 1000, 
        min_height = 10,
        max_height = 100,
        day_toggle = true,
    })
end

if ROCKMONSTER_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/monsters/rockmonster.lua")

    mobs:register_egg("ccmobs2:rockmonster", "Rock Monster", "ccmobs2_spawnegg_rockmonster.png", 0)

    mobs:spawn({
        name = "ccmobs2:rockmonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:stone"},
        min_light = 3,
        max_light = 5,
        interval = 60,
        chance = 1200, 
        min_height = -100,
        max_height = 1200,
        day_toggle = false,
    })
end

if TREEMONSTER_SPAWN then
    dofile(minetest.get_modpath("ccmobs2").."/monsters/treemonster.lua")

    mobs:register_egg("ccmobs2:treemonster", "Tree Monster", "ccmobs2_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "ccmobs2:treemonster",
        nodes = {"default:dirt_with_grass"},
        neighbors = {"group:leaves"},
        min_light = 3,
        max_light = 5,
        interval = 60,
        chance = 900, 
        min_height = 10,
        max_height = 800,
        day_toggle = false,
    })
end


-- bucket of milk
minetest.register_craftitem("ccmobs2:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "ccmobs2_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})
