local modpath, S, mg_name = ...

--
-- Clementinetree
--

minetest.register_node("brewing:clementine", {
	description = S("Clementine"),
	drawtype = "plantlike",
	tiles = {"brewing_clementine.png"},
	inventory_image = "brewing_clementine.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "brewing:clementine", param2 = 1})
	end,
})

brewing.clementinetree = {}


-- clementinetree

local function grow_new_clementinetree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end

	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}, modpath.."/schematics/clementinetree.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_clementinetree == true then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.00004,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/clementinetree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("brewing:clementinetree_sapling", {
	description = S("Clementine Tree Sapling"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"brewing_clementinetree_sapling.png"},
	inventory_image = "brewing_clementinetree_sapling.png",
	wield_image = "moretrees_birch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_clementinetree_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"brewing:clementinetree_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("brewing:clementinetree_trunk", {
	description = S("Clementine Tree Trunk"),
	tiles = {
		"brewing_clementinetree_trunk_top.png",
		"brewing_clementinetree_trunk_top.png",
		"brewing_clementinetree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		brewing.get_cork(pos, node, player)
		minetest.item_place_node(itemstack, player, pointed_thing, nil)
	end
})

minetest.register_node("brewing:clementinetree_trunk_nobark", {
	description = S("Clementine Tree Trunk"),
	tiles = {
		"brewing_clementinetree_trunk_top.png",
		"brewing_clementinetree_trunk_top.png",
		"brewing_clementinetree_trunk_nobark.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- clementinetree wood
minetest.register_node("brewing:clementinetree_wood", {
	description = S("Clementine Tree Wood"),
	tiles = {"brewing_clementinetree_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- clementinetree tree leaves
minetest.register_node("brewing:clementinetree_leaves", {
	description = S("Clementine Tree Leaves"),
	drawtype = "allfaces_optional",
	visual_scale = 1.2,
	tiles = {"brewing_clementinetree_leaves.png"},
	inventory_image = "brewing_clementinetree_leaves.png",
	wield_image = "brewing_clementinetree_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"brewing:clementinetree_sapling"}, rarity = 20},
			{items = {"brewing:clementinetree_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "brewing:clementinetree_wood 4",
	recipe = {{"brewing:clementinetree_trunk"}}
})

minetest.register_craft({
	output = "brewing:clementinetree_wood 4",
	recipe = {{"brewing:clementinetree_trunk_nobark"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "brewing:clementinetree_trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "brewing:clementinetree_trunk_nobark",
	burntime = 25,
})

minetest.register_craft({
	type = "fuel",
	recipe = "brewing:clementinetree_wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "brewing:convert_clementinetree_saplings_to_node_timer",
	nodenames = {"brewing:clementinetree_sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"brewing:clementinetree_trunk"},
	leaves = {"brewing:clementinetree_leaves"},
	radius = 3,
})

--Clementine Jam

minetest.register_craftitem("brewing:clementine_jam", {
	description = S("Clementine Jam"),
	inventory_image = "brewing_clementine_jam.png",
	on_use = minetest.item_eat(4, "brewing:jar")
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_jam",
	recipe = {
		{"", "brewing:clementine", ""},
		{"", "brewing:sugar", ""},
		{"", "brewing:jar", "default:paper"},
	}
})

--Clementine Cotton Candy

minetest.register_craftitem("brewing:clementine_cotton_candy", {
	description = S("Clementine Cotton Candy"),
	inventory_image = "brewing_clementine_cotton_candy.png",
	on_use = minetest.item_eat(6, "default:stick"),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_cotton_candy",
	recipe = {
		{"brewing:clementine", "brewing:clementine", "brewing:clementine"},
		{"brewing:clementine", "brewing:sugar", "brewing:clementine"},
		{"", "default:stick", ""},
	}
})

--Clementine Chupachups

minetest.register_craftitem("brewing:clementine_chupachups", {
	description = S("Clementine Chupachups"),
	inventory_image = "brewing_clementine_chupachups.png",
	on_use = minetest.item_eat(3, "default:stick"),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_chupachups 4",
	recipe = {
		{"", "brewing:clementine", ""},
		{"brewing:clementine", "brewing:sugar", "brewing:clementine"},
		{"", "default:stick", ""},
	}
})
