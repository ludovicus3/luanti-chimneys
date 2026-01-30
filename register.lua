local S = core.get_translator(core.get_current_modname())

chimneys.register_chimney_def("chimneys:chimney_cobble",{
	source = "mcl_core:cobble",
	description = S("Cobblestone Chimney"),
	--tiles = {"chimneys_cobble_chimney_top.png", "default_cobble.png", "chimneys_cobble_chimney_side.png"},
	_mcl_stonecutter_recipes = { "mcl_core:cobble" },
})
chimneys.register_chimney_def("chimneys:chimney_mossycobble", {
	source = "mcl_core:mossycobble",
	description = S("Mossy Cobblestone Chimney"),
	--tiles = {"chimneys_cobble_mossy_chimney_top.png", "default_mossycobble.png", "chimneys_cobble_mossy_chimney_side.png"},
	_mcl_stonecutter_recipes = { "mcl_core:mossycobble" },
})
chimneys.register_chimney_def("chimneys:chimney_andesite", {
	description = S("Andesite Chimney"),
	source = "mcl_core:andesite",
	_mcl_stonecutter_recipes = {"mcl_core:andesite"},
})
chimneys.register_chimney_def("chimneys:chimney_granite", {
	description = S("Granite Chimney"),
	source = "mcl_core:granite",
	_mcl_stonecutter_recipes = {"mcl_core:granite",},
})
chimneys.register_chimney_def("chimneys:chimney_diorite", {
	description = S("Diorite Chimney"),
	source = "mcl_core:diorite",
	_mcl_stonecutter_recipes = {"mcl_core:diorite",},
})
chimneys.register_chimney_def("chimneys:chimney_brick", {
	description = S("Brick Chimney"),
	source = "mcl_core:brick_block",
	_mcl_stonecutter_recipes = {"mcl_core:brick_block",},
})
chimneys.register_chimney_def("chimneys:chimney_sandstone", {
	description = S("Sandstone Chimney"),
	source = "mcl_core:sandstone",
	_mcl_stonecutter_recipes = {"mcl_core:sandstone",},
})
chimneys.register_chimney_def("chimneys:chimney_redsandstone", {
	description = S("Red Sandstone Chimney"),
	source = "mcl_core:redsandstone",
	_mcl_stonecutter_recipes = {"mcl_core:redsandstone",},
})
chimneys.register_chimney_def("chimneys:chimney_stonebrick", {
	description = S("Stone Brick Chimney"),
	source = "mcl_core:stonebrick",
	_mcl_stonecutter_recipes = {"mcl_core:stonebrick", "mcl_core:stone"},
})
chimneys.register_chimney_def("chimneys:chimney_stonebrickmossy", {
	description = S("Mossy Stone Brick Chimney"),
	source = "mcl_core:stonebrickmossy",
	_mcl_stonecutter_recipes = {"mcl_core:stonebrickmossy",},
})
chimneys.register_chimney_def("chimneys:chimney_prismarine", {
	description = S("Prismarine Chimney"),
	source = "mcl_ocean:prismarine",
	_mcl_stonecutter_recipes = {"mcl_ocean:prismarine",},
})
chimneys.register_chimney_def("chimneys:chimney_endbricks", {
	description = S("End Stone Brick Chimney"),
	source = "mcl_end:end_bricks",
	_mcl_stonecutter_recipes = {"mcl_end:end_bricks","mcl_end:end_stone"},
})
chimneys.register_chimney_def("chimneys:chimney_netherbrick", {
	description = S("Nether Brick Chimney"),
	source = "mcl_nether:nether_brick",
	_mcl_stonecutter_recipes = {"mcl_nether:nether_brick",},
})
chimneys.register_chimney_def("chimneys:chimney_rednetherbrick", {
	description = S("Red Nether Brick Chimney"),
	source = "mcl_nether:red_nether_brick",
	_mcl_stonecutter_recipes = {"mcl_nether:red_nether_brick",},
})
chimneys.register_chimney_def("chimneys:chimney_mudbrick", {
	description = S("Mud Brick Chimney"),
	source = "mcl_mud:mud_bricks",
	_mcl_stonecutter_recipes = {"mcl_mud:mud_bricks",},
})

