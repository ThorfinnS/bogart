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
local PIGGY_SPAWN = true
local PANDA_SPAWN = true
local LAMB_SPAWN = true
local CALF_SPAWN = true
local CHICKEN_SPAWN = true
local DUCKY_SPAWN = true


if KITTY_SPAWN then

    dofile(modpath.."/kitty.lua")

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

if PIGGY_SPAWN then

    dofile(modpath.."/piggy.lua")

    mobs:register_egg("pets:piggy", S("Piggy"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:piggy",
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

if PANDA_SPAWN then

    dofile(modpath.."/panda.lua")

    mobs:register_egg("pets:panda", S("Panda"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:panda",
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

if LAMB_SPAWN then

    dofile(modpath.."/lamb.lua")

    mobs:register_egg("pets:lamb", S("Lamb"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:lamb",
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

if CALF_SPAWN then

    dofile(modpath.."/calf.lua")

    mobs:register_egg("pets:calf", S("Calf"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:calf",
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

if CHICKEN_SPAWN then

    dofile(modpath.."/chicken.lua")

    mobs:register_egg("pets:chicken", S("Chicken"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:chicken",
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


if DUCKY_SPAWN then

    dofile(modpath.."/ducky.lua")

    mobs:register_egg("pets:ducky", S("Ducky"), "pets_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "pets:ducky",
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