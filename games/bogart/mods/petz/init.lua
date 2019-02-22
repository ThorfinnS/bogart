--
-- petz 
-- License:MIT
--

local modname = "petz"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

petz = {}

--TYPE_MODEL: [mesh --or--  cubic]
local TYPE_MODEL = "mesh"

local Mesh = nil
local VisualSize = {}
local Rotate = 0
local Textures = {}
local CollisionBox = {}

if TYPE_MODEL == "mesh" then
    Visual = "mesh"
    VisualSize = {x=10.0, y=10.0}
    Rotate = 0
else -- is 'cubic'
    Visual = "wielditem"
    VisualSize = {x=1.0, y=1.0}
    Rotate = 180
end

--SPAWNING: [true --or-- false]
local KITTY_SPAWN = true
local PIGGY_SPAWN = true
local PANDA_SPAWN = true
local LAMB_SPAWN = true
local CALF_SPAWN = true
local CHICKEN_SPAWN = true
local DUCKY_SPAWN = true


if KITTY_SPAWN then

    assert(loadfile(modpath .. "/kitty.lua"))(TYPE_MODEL, Visual, VisualSize, Mesh, Rotate, Textures, CollisionBox) 

    mobs:register_egg("petz:kitty", S("Kitty"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:kitty",
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

    mobs:register_egg("petz:piggy", S("Piggy"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:piggy",
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

    mobs:register_egg("petz:panda", S("Panda"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:panda",
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

    mobs:register_egg("petz:lamb", S("Lamb"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:lamb",
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

    mobs:register_egg("petz:calf", S("Calf"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:calf",
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

    mobs:register_egg("petz:chicken", S("Chicken"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:chicken",
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

    mobs:register_egg("petz:ducky", S("Ducky"), "petz_spawnegg_treemonster.png", 0)

    mobs:spawn({
        name = "petz:ducky",
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