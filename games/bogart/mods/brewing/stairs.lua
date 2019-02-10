local modpath, S = ...

--Magic Block

stairs.register_stair_and_slab(
	"magic_block",
	"brewing:magic_block",
	{cracky = 1, level = 2},
	{"brewing_magic_block.png"},
	S("Stair Magic Block"),
	S("Slab Magic Block"),
	default.node_sound_glass_defaults()
)

--Lemmontree


if minetest.get_modpath("tree_stairs") ~= nil then

	tree_stairs.register_stair(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"brewing_lemmontree_trunk.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front.png"},
		S("Lemmon Tree Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_slab(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk.png",},
		S("Lemmon Tree Slab"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_inner(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"ts_lemmontree_front_right.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front_right.png^[transformFX"},
		S("Lemmon Tree Inner Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_outer(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"ts_lemmontree_front.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front.png"},
		S("Lemmon Tree Outer Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair(
		"brewing_clementinetree",
		"brewing:clementinetree",
		{cracky = 3},
		{"brewing_clementinetree_trunk_top.png", "brewing_clementinetree_trunk_top.png",
		"brewing_clementinetree_trunk.png", "brewing_clementinetree_trunk.png",
		"brewing_clementinetree_trunk.png", "ts_clementinetree_front.png"},
		S("Clementine Tree Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_slab(
		"brewing_clementinetree",
		"brewing:clementinetree",
		{cracky = 3},
		{"brewing_clementinetree_trunk_top.png", "brewing_clementinetree_trunk_top.png", "brewing_clementinetree_trunk.png",},
		S("Clementine Tree Slab"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_inner(
		"brewing_clementinetree",
		"brewing:clementinetree",
		{cracky = 3},
		{"brewing_clementinetree_trunk_top.png", "brewing_clementinetree_trunk_top.png",
		"ts_clementinetree_front_right.png", "brewing_clementinetree_trunk.png",
		"brewing_clementinetree_trunk.png", "ts_clementinetree_front_right.png^[transformFX"},
		S("Clementine Tree Inner Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_outer(
		"brewing_clementinetree",
		"brewing:clementinetree",
		{cracky = 3},
		{"brewing_clementinetree_trunk_top.png", "brewing_clementinetree_trunk_top.png",
		"ts_clementinetree_front.png", "brewing_clementinetree_trunk.png",
		"brewing_clementinetree_trunk.png", "ts_clementinetree_front.png"},
		S("Clementine Tree Outer Stair"),
		default.node_sound_wood_defaults(),
		false
	)

else

	stairs.register_stair_and_slab(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"brewing_lemmontree_wood.png"},
		S("Lemmon Tree Stair"),
		S("Lemmon Tree Slab"),
		default.node_sound_wood_defaults()
	)

	stairs.register_stair_and_slab(
		"brewing_clementinetree",
		"brewing:clementinetree",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"brewing_clementinetree_wood.png"},
		S("Clementine Tree Stair"),
		S("Clementine Tree Slab"),
		default.node_sound_wood_defaults()
	)
end