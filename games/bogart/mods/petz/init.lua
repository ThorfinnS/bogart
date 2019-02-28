--
-- petz 
-- License:GPL3
--

local modname = "petz"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

petz = {}

petz.settings = {}

petz.register_cubic = function(node_name, fixed, tiles)
		minetest.register_node("petz:kitty_block", {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {fixed},
		},
		tiles = {tiles},
		paramtype = "light",
		paramtype2 = "facedir",
    	groups = {not_in_creative_inventory = 1},
	})		
end

--Load the settings
assert(loadfile(modpath .. "/settings.lua"))(modpath, S)

petz.settings.mesh = nil
petz.settings.visual_size = {}
petz.settings.rotate = 0
petz.settings.textures = {}
petz.settings.collisionbox = {}

if petz.settings.type_model == "mesh" then
    petz.settings.visual = "mesh"
    petz.settings.visual_size = {x=15.0, y=15.0}
    petz.settings.rotate = 0
else -- is 'cubic'
    petz.settings.visual = "wielditem"
    petz.settings.visual_size = {x=1.0, y=1.0}
    petz.settings.rotate = 180
end

--Form Dialog

petz.pet = nil

petz.create_form = function(pet_name)
	local form_pet_orders =
		"size[3,5;]"..
		"image[1,0;1,1;petz_spawnegg_"..pet_name..".png]"..
		"button_exit[0,1;3,1;btn_followme;"..S("Follow me").."]"..
		"button_exit[0,2;3,1;btn_standhere;"..S("Stand here").."]"..
		"button_exit[0,3;3,1;btn_ownthing;"..S("Do your own thing").."]"..	
		"button_exit[1,4;1,1;btn_close;"..S("Close").."]"
	return form_pet_orders
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (formname ~= "petz:form_orders") then
		return false
	end
	if petz.pet == nil then -- if pet dies after her formspec opened
		return true
	end
	--brewing.magic_sound("to_player", player, "brewing_select")
	if fields.btn_followme then
		petz.pet.order = "follow"
	elseif fields.btn_standhere then
		petz.pet.order = "stand"
	elseif fields.btn_ownthing then
		petz.pet.order = ""
		petz.pet.state = "walk"
	end
	return true
end)

if petz.settings.kitty_spawn then

    assert(loadfile(modpath .. "/kitty_"..petz.settings.type_api..".lua"))(S, petz.settings.type_model, petz.settings.visual, petz.settings.visual_size, petz.settings.mesh, petz.settings.rotate, petz.settings.textures, petz.settings.collisionbox, petz.settings.kitty_follow, petz.settings.kitty_food) 

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

if petz.settings.puppy_spawn then

    assert(loadfile(modpath .. "/puppy_"..petz.settings.type_api..".lua"))(S, petz.settings.type_model, petz.settings.visual, petz.settings.visual_size, petz.settings.mesh, petz.settings.rotate, petz.settings.textures, petz.settings.collisionbox, petz.settings.puppy_follow, petz.settings.puppy_food) 

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