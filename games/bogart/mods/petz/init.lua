--
-- petz 
-- License:GPL3
--

local modname = "petz"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

petz = {}

petz.register_cubic = function(node_name, fixed, tiles)
		minetest.register_node(node_name, {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = fixed,
		},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
    	groups = {not_in_creative_inventory = 1},
	})		
end

petz.settings = {}

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

petz.pet = {}

petz.create_form = function(player_name, pet_name)
    local pet = petz.pet[player_name] 
    if pet.affinity == nil then
        pet.affinity = 0
    end
	local form_pet_orders = "size[3,5;]"
    if petz.settings.type_api == "mobkit" then        
		form_pet_orders = form_pet_orders.."image[0,0;1,1;petz_spawnegg_"..pet_name..".png]"..
                "image[1,0;1,1;petz_affinity_heart.png]"..
                "label[2,0;".. tostring(pet.affinity).."%]"
    else
        form_pet_orders = form_pet_orders.."image[1,0;1,1;petz_spawnegg_"..pet_name..".png]"
    end
    form_pet_orders = form_pet_orders..
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
    local pet = petz.pet[player:get_player_name()] 
	if pet == nil then -- if pet dies after her formspec opened
		return false
	end
	--brewing.magic_sound("to_player", player, "brewing_select")
	if fields.btn_followme then
		pet.order = "follow"
	elseif fields.btn_standhere then
		pet.order = "stand"
	elseif fields.btn_ownthing then
		pet.order = ""
		pet.state = "walk"
	end
	return true
end)

petz.on_rightclick = function(self, clicker, pet_name)
        if not(clicker:is_player()) then
            return false
        end
        local player_name = clicker:get_player_name()
        if (self.owner ~= player_name) then
            return
        end
        local wielded_item = clicker:get_wielded_item()
        if wielded_item:get_name() == food then
            if self.health < self.hp_max then
                self.health = self.health + 2
                -- Decrease eat
                local inv = clicker:get_inventory()
                local count = wielded_item:get_count()
                count = count - 1
                if count >= 0 then
                    wielded_item:set_count(count)
                    local wielded_index = clicker:get_wield_index()
                    local wielded_list_name = clicker:get_wield_list()
                    inv:set_stack(wielded_list_name, wielded_index, wielded_item)
                    --brewing.magic_sound("to_player", clicker, "brewing_eat")
                end
            else
                --brewing.magic_sound("to_player", clicker, "brewing_magic_failure")
            end
        else
            petz.pet[player_name]= self 
            minetest.show_formspec(player_name, "petz:form_orders", petz.create_form(player_name, pet_name))
        end
end

petz.on_die = function(self, pos)
    petz.pet[self.owner]= nil
end

petz.do_punch = function (self, hitter, time_from_last_punch, tool_capabilities, direction)
    if petz.settings.type_api == "mobkit" then 
        if self.owner == hitter:get_player_name() then
            self.affinity = self.affinity - 20
        end
    end
end

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