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

--Pet Bowl
minetest.register_node("petz:pet_bowl", {
    description = S("Pet Bowl"),
    inventory_image = "petz_pet_bowl_inv.png",
    wield_image = "petz_pet_bowl_inv.png",
    tiles = {"petz_pet_bowl.png"},
    groups = {snappy=1, bendy=2, cracky=1},
    sounds = default_stone_sounds,
    paramtype = "light",
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875}, -- bottom
            {-0.1875, -0.4375, -0.1875, 0.1875, -0.375, -0.125}, -- front
            {-0.1875, -0.4375, 0.125, 0.1875, -0.375, 0.1875}, -- back
            {-0.1875, -0.4375, -0.125, -0.125, -0.375, 0.125}, -- left
            {0.125, -0.4375, -0.125, 0.1875, -0.375, 0.125}, -- right
            },
        },
})
 
minetest.register_craft({
    type = "shaped",
    output = 'petz:pet_bowl',
    recipe = {        
        {'group:wood', '', 'group:wood'},
        {'group:wood', 'group:wood', 'group:wood'},
        {'', 'dye:red', ''},
    }
})

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