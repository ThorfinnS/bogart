--
-- pets 
-- License:MIT
--

local modname = "pets"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

pets = {}

--SPAWNING: [true --or-- false]
local KITTY_SPAWN = true


if KITTY_SPAWN then

    dofile(minetest.get_modpath("pets").."/kitty.lua")

    mobs:register_egg("pets:kitty", S("Kitty"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:kitty",
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
