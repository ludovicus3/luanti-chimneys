local chimney_base_nodes = {
    "mcl_core:cobble",
    "mcl_core:stonebrick",
    "mcl_core:stone",
    "mcl_core:granite",
    "mcl_core:granite_smooth",
    "mcl_core:diorite",
    "mcl_core:diorite_smooth",
    "mcl_core:andesite",
    "mcl_core:andesite_smooth",
    "mcl_deepslate:deepslate",
    "mcl_deepslate:deepslate_bricks",
    "mcl_deepslate:deepslate_bricks_cracked",
    "mcl_deepslate:deepslate_chiseled",
    "mcl_deepslate:deepslate_cobbled",
    "mcl_deepslate:deepslate_polished",
    "mcl_deepslate:deepslate_tiles",
    "mcl_deepslate:deepslate_tiles_cracked",
    "mcl_nether:nether_brick",
    "mcl_nether:chiseled_nether_brick",
    "mcl_nether:cracked_nether_brick",
    "mcl_nether:red_nether_brick",
    "mcl_nether:netherrack",
    "mcl_nether:quartz_block",
    "mcl_nether:quartz_chiseled",
    "mcl_nether:quartz_pillar",
    "mcl_nether:quartz_smooth",
    "mcl_deepslate:tuff",
    "mcl_deepslate:tuff_bricks",
    "mcl_deepslate:tuff_chiseled",
    "mcl_deepslate:tuff_chiseled_bricks",
    "mcl_deepslate:tuff_polished",
}

for _, chimney_base_node in ipairs(chimney_base_nodes) do
    if core.registered_nodes[chimney_base_node] then
        local chimney_name = chimney_base_node:match(":(.+)")
        chimney.register_chimney(chimney_name, {material = chimney_base_node})
    else
        core.log("warning", "[chimney] Didn't find the node " .. chimney_base_node)
    end
end
