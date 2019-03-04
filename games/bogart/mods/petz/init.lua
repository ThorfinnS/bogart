--
-- petz 
-- License:GPL3
--

local modname = "petz"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

assert(loadfile(modpath .. "/api.lua"))(S)
assert(loadfile(modpath .. "/settings.lua"))(modpath, S) --Load the settings

if petz.settings.kitty_spawn then

    assert(loadfile(modpath .. "/kitty_"..petz.settings.type_api..".lua"))(S) 

    mobs:register_egg("petz:kitty", S("Kitty"), "petz_spawnegg_kitty.png", 0)

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

--Pet Hairbrush
if petz.settings.tamagochi_mode then

    minetest.register_craftitem("petz:hairbrush", {
        description = S("Hairbrush"),
        inventory_image = "petz_hairbrush.png",
        wield_image = "petz_hairbrush.png"
    })

    minetest.register_craft({
        type = "shaped",
        output = "petz:hairbrush",
        recipe = {
            {"", "", ""},
            {"", "default:stick", "farming:string"},
            {"default:stick", "", ""},
        }
    })
end

if petz.settings.puppy_spawn then

    assert(loadfile(modpath .. "/puppy_"..petz.settings.type_api..".lua"))(S) 

    mobs:register_egg("petz:puppy", S("Puppy"), "petz_spawnegg_puppy.png", 0)

    mobs:spawn({
        name = "petz:puppy",
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