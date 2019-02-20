-- Minetest 0.4 mod: columnia by Glunggi(former Stairs Copyright by(C) 2011-2012 Kahrl <kahrl@gmx.net> Copyright (C) 2011-2012 celeron55, Perttu Ahola)
-- See README.txt for licensing and other information.

local modname = "columnia"
local modpath = minetest.get_modpath(modname)

columnia = {}

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- The Blueprint
minetest.register_craftitem("columnia:blueprint", {
	description = S("Column Blueprint"),
	inventory_image = "columnia_blueprint.png",
})

minetest.register_craft({
	output = 'columnia:blueprint',
	recipe = {
		{'default:paper', 'group:stick', 'default:paper'},
		{'default:paper', 'default:coal_lump', 'default:paper'},
		{'default:paper', 'group:stick', 'default:paper'},
	}
})

-- Bracket 
minetest.register_node("columnia:bracket",	{ 
            description = S('Bracket (Column)'),
			tiles = {"columnia_rusty.png",},
			drawtype = "nodebox",
			sunlight_propagates = true,
			paramtype = 'light',
			paramtype2 = "facedir",
			node_box = {
				type = "fixed",
				fixed = {
			        {-0.25, 0, 0.4375, 0.25, 0.5, 0.5},
			        {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
			        {-0.0625, -0.375, -0.0625, 0.0625, 0.1875, 0.0625},
			        {-0.0625, 0.1875, -0.0625, 0.0625, 0.3125, 0.4375},
			        {-0.1875, 0.0625, 0.3125, 0.1875, 0.4375, 0.4375},
			        {-0.125, -0.375, -0.125, 0.125, -0.25, 0.125},
		        },
			},
			groups = {choppy=2, oddly_breakable_by_hand=2,},
			sounds = default.node_sound_stone_defaults(),
})
		
minetest.register_craft({
		output = 'columnia:bracket 4',
		recipe = {
			{"default:steel_ingot", "columnia:blueprint", ""},
			{"", "default:steel_ingot", ""},
			{"", "default:steel_ingot", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
})

-- Lamp
minetest.register_node("columnia:lamp_ceiling", {
    description = S("Ceiling Lamp (Column)"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	inventory_image = "columnia_lamp_inv.png",
	tiles = {
	         "columnia_rusty.png", "columnia_lamp.png", "columnia_lamp.png",
		     "columnia_lamp.png", "columnia_lamp.png", "columnia_lamp.png"
	        },
	sunlight_propagates = true,
	light_source = 13,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, 0.4375, -0.1875, 0.1875, 0.5, 0.1875},
			{-0.125, 0.375, -0.125, 0.125, 0.4375, 0.125}, 
		},
	},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
		output = 'columnia:lamp_ceiling 4',
		recipe = {
			{"columnia:blueprint", "default:steel_ingot", ""},
			{"", "default:torch", ""},
			{"", "default:glass", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
})

-- Rusty_Block

minetest.register_node("columnia:rusty_block", {
	description = S("Rusty Block"),
	tiles = {"columnia_rusty_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
		output = 'columnia:rusty_block 8',
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "columnia:blueprint", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
})

-- Now the Column
-- Node will be called columnia:column_mid_<subname>
function columnia.register_column_mid(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_mid_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			     {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		    },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_mid_" .. subname.."upside_down", {
		replace_name = "columnia:column_mid_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_mid_' .. subname .. ' 2',
		recipe = {
			{"", recipeitem, ""},
			{"", "columnia:blueprint", ""},
			{"", recipeitem, ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end


-- Node will be called columnia:column_top_<subname>
function columnia.register_column_top(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_top_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			   {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
			   {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, 
			   {-0.375, 0, -0.375, 0.375, 0.5, 0.375},
		    },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_top_" .. subname.."upside_down", {
		replace_name = "columnia:column_top_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_top_' .. subname .. ' 4',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, ""},
			{"", "columnia:blueprint", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end

-- Node will be called columnia:column_bottom_<subname>
function columnia.register_column_bottom(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_bottom_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			    {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
			    {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			    {-0.375, -0.5, -0.375, 0.375, 0, 0.375},
            },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_bottom_" .. subname.."upside_down", {
		replace_name = "columnia:column_bottom_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_bottom_' .. subname .. ' 4',
		recipe = {
			{"", "columnia:blueprint", ""},
			{"", recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end
-- Node will be called columnia:column_crosslink<subname>
function columnia.register_column_crosslink(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_crosslink_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			   {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
			   {-0.5, 0, -0.25, 0.5, 0.5, 0.25},
			   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
			   {-0.4375, 0.0625, -0.4375, 0.4375, 0.4375, 0.4375},
		    },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_crosslink_" .. subname.."upside_down", {
		replace_name = "columnia:column_crosslink_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_crosslink_' .. subname .. ' 4',
		recipe = {
			{"", recipeitem, ""},
			{recipeitem, "columnia:blueprint", recipeitem},
			{"", recipeitem, ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end

-- Node will be called columnia:column_link<subname>
function columnia.register_column_link(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_link_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			    {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		    },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_link_" .. subname.."upside_down", {
		replace_name = "columnia:column_link_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_link_' .. subname .. ' 2',
		recipe = {
			{recipeitem, "columnia:blueprint", recipeitem},
			{"", "", ""},
			{"", "", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end

-- Node will be called columnia:column_linkdown<subname>
function columnia.register_column_linkdown(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":columnia:column_linkdown_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
			   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
			   {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
			   {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
			   {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875},
		    },
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":columnia:column_linkdown_" .. subname.."upside_down", {
		replace_name = "columnia:column_linkdown_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'columnia:column_linkdown_' .. subname .. ' 3',
		recipe = {
			{recipeitem, "columnia:blueprint", recipeitem},
			{"", recipeitem, ""},
			{"", "", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
	})
end


-- Nodes will be called columnia:{column}_<subname>
function columnia.register_column_ia(subname, recipeitem, groups, images, desc_column_mid, desc_column_top, desc_column_bottom, desc_column_crosslink, desc_column_link, desc_column_linkdown, sounds)
	columnia.register_column_mid(subname, recipeitem, groups, images, desc_column_mid, sounds)
	columnia.register_column_top(subname, recipeitem, groups, images, desc_column_top, sounds)
	columnia.register_column_bottom(subname, recipeitem, groups, images, desc_column_bottom, sounds)
	columnia.register_column_crosslink(subname, recipeitem, groups, images, desc_column_crosslink, sounds)
	columnia.register_column_link(subname, recipeitem, groups, images, desc_column_link, sounds)
	columnia.register_column_linkdown(subname, recipeitem, groups, images, desc_column_linkdown, sounds)
end

columnia.register_column_ia("rusty_block", "columnia:rusty_block",
		{cracky=3},
		{"columnia_rusty_block.png"},
		S("Rusty Column"),
		S("Rusty Column Top"),
		S("Rusty Column Bottom"),
		S("Rusty Column Crosslink"),
		S("Rusty Column Link"),
		S("Rusty Column Linkdown"),
		default.node_sound_stone_defaults()
        )

columnia.register_column_ia("stone", "default:stone",
		{cracky=3},
		{"default_stone.png"},
		S("Stone Column"),
		S("Stone Column Top"),
		S("Stone Column Bottom"),
		S("Stone Column Crosslink"),
		S("Stone Column Link"),
		S("Stone Column Linkdown"),
		default.node_sound_stone_defaults()
        )
		
columnia.register_column_ia("stonebrick", "default:stonebrick",
		{cracky=3},
		{"default_stone_brick.png"},
		S("Stone Brick Column"),
		S("Stone Brick Column Top"),
		S("Stone Brick Column Bottom"),
		S("Stone Brick Column Crosslink"),
		S("Stone Brick Column Link"),
		S("Stone Brick Column Linkdown"),
		default.node_sound_stone_defaults()
        )

columnia.register_column_ia("desert_stonebrick", "default:desert_stonebrick",
		{cracky=3},
		{"default_desert_stone_brick.png"},
		S("Desert Stone Brick Column"),
		S("Desert Stone Brick Column Top"),
		S("Desert Stone Brick Column Bottom"),
		S("Desert Stone Brick Column Crosslink"),
		S("Desert Stone Brick Column Link"),
		S("Desert Stone Brick Column Linkdown"),
		default.node_sound_stone_defaults()
        )	

columnia.register_column_ia("desert_stone", "default:desert_stone",
		{cracky=3},
		{"default_desert_stone.png"},
		S("Desert Stone Column"),
		S("Desert Stone Column Top"),
		S("Desert Stone Column Bottom"),
		S("Desert Stone Column Crosslink"),
		S("Desert Stone Column Link"),
		S("Desert Stone Column Linkdown"),
		default.node_sound_stone_defaults()
        )		
		
columnia.register_column_ia("cobble", "default:cobble",
		{cracky=3},
		{"default_cobble.png"},
		S("Cobble Column"),
		S("Cobble Column Top"),
		S("Cobble Column Bottom"),
		S("Cobble Column Crosslink"),
		S("Cobble Column Link"),
		S("Cobble Column Linkdown"),
		default.node_sound_stone_defaults()
        )

columnia.register_column_ia("brick", "default:brick",
		{cracky=3},
		{"default_brick.png"},
		S("Brick Column"),
		S("Brick Column Top"),
		S("Brick Column Bottom"),
		S("Brick Column Crosslink"),
		S("Brick Column Link"),
		S("Brick Column Linkdown"),
		default.node_sound_stone_defaults()
        )	
			
columnia.register_column_ia("sandstone", "default:sandstone",
		{crumbly=2,cracky=2},
		{"default_sandstone.png"},
		S("Sandstone Column"),
		S("Sandstone Column Top"),
		S("Sandstone Column Bottom"),
		S("Sandstone Column Crosslink"),
		S("Sandstone Column Link"),
		S("Sandstone Column Linkdown"),
		default.node_sound_stone_defaults()
        )
		
columnia.register_column_ia("sandstonebrick", "default:sandstonebrick",
		{crumbly=2,cracky=2},
		{"default_sandstone_brick.png"},
		S("Sandstone Brick Column"),
		S("Sandstone Brick Column Top"),
		S("Sandstone Brick Column Bottom"),
		S("Sandstone Brick Column Crosslink"),
		S("Sandstone Brick Column Link"),
		S("Sandstone Brick Column Linkdown"),
		default.node_sound_stone_defaults()
        )
		
columnia.register_column_ia("wood", "default:wood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_wood.png"},
		S("Wooden Column"),
		S("Wooden Column Top"),
		S("Wooden Column Bottom"),
		S("Wooden Column Crosslink"),
		S("Wooden Column Link"),
		S("Wooden Column Linkdown"),
		default.node_sound_wood_defaults())

columnia.register_column_ia("junglewood", "default:junglewood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_junglewood.png"},
		S("Junglewood Column"),
		S("Junglewood Column Top"),
		S("Junglewood Column Bottom"),
		S("Junglewood Column Crosslink"),
		S("Junglewood Column Link"),
		S("Junglewood Column Linkdown"),
		default.node_sound_wood_defaults())

columnia.register_column_ia("pinewood", "default:pine_wood",
        {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
        {"default_pine_wood.png"},
        S("Pinewood Column"),
        S("Pineewood Column Top"),
        S("Pineewood Column Bottom"),
        S("Pineewood Column Crosslink"),
        S("Pineewood Column Link"),
        S("Pineewood Column Linkdown"),
        default.node_sound_wood_defaults())

if core.get_modpath( 'moretrees' ) then
	local morewood = {
		{ name='beech', description='Beech Tree' },
		{ name='apple_tree',	description='Apple Tree' },
		{ name='oak', description='Oak Tree' },
		{ name='sequoia', description='Giant Sequoia' },
		{ name='birch', description='Birch Tree' },
		{ name='palm', description='Palm Tree', },
		{ name='spruce', description='Spruce Tree' },
		{ name='willow', description='Willow Tree' },
		{ name='acacia', description='Acacia Tree' },
		{ name='rubber_tree',	description='Rubber Tree' },
		{ name='fir', description='Douglas Fir' }
	}
	for _,t in pairs( morewood ) do
		print('register: '.. t.name)
		columnia.register_column_ia( t.name, 'moretrees:' .. t.name ..'_planks',
			{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
			{ 'moretrees_' .. t.name .. '_wood.png' },
			t.description .. ' Column',
			t.description .. ' Column Top',
			t.description .. ' Column Bottom',
			t.description .. ' Column Crosslink',
			t.description .. ' Column Link',
			t.description .. ' Column Linkdown',
			default.node_sound_wood_defaults())
	end
end

if core.get_modpath('moreblocks') then
	stairsplus:register_all(
                'columnia',
                'rusty_block',
                'columnia:rusty_block',
                {
                        description = S('Rusty Block'),
                        tiles = {
				'columnia_rusty_block.png'
			},
                        groups = {cracky=3},
                        sounds = default.node_sound_stone_defaults(),
                }
        )
end
