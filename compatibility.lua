local old_chimney_nodes = {
    ["chimney:chimney_cobble_stone"]              = "chimney:chimney_cobble",
    ["chimney:chimney_roof_plate_cobble_stone"]   = "chimney:roof_plate_cobble",
    ["chimney:chimney_trim_cobble_stone"]         = "chimney:trim_cobble",

    ["chimney:chimney_stone_brick"]               = "chimney:chimney_stonebrick",
    ["chimney:chimney_roof_plate_stone_brick"]    = "chimney:roof_plate_stonebrick",
    ["chimney:chimney_trim_stone_brick"]          = "chimney:trim_stonebrick",

    ["chimney:chimney_stone"]                     = "chimney:chimney_stone",
    ["chimney:chimney_roof_plate_stone"]          = "chimney:roof_plate_stone",
    ["chimney:chimney_trim_stone"]                = "chimney:trim_stone",

    ["chimney:chimney_granite"]                   = "chimney:chimney_granite",
    ["chimney:chimney_roof_plate_granite"]        = "chimney:roof_plate_granite",
    ["chimney:chimney_trim_granite"]              = "chimney:trim_granite",

    ["chimney:chimney_smooth_granite"]            = "chimney:chimney_granite_smooth",
    ["chimney:chimney_roof_plate_smooth_granite"] = "chimney:roof_plate_granite_smooth",
    ["chimney:chimney_trim_smooth_granite"]       = "chimney:trim_granite_smooth",

    ["chimney:chimney_diorite"]                   = "chimney:chimney_diorite",
    ["chimney:chimney_roof_plate_diorite"]        = "chimney:roof_plate_diorite",
    ["chimney:chimney_trim_diorite"]              = "chimney:trim_diorite",

    ["chimney:chimney_smooth_diorite"]            = "chimney:chimney_diorite_smooth",
    ["chimney:chimney_roof_plate_smooth_diorite"] = "chimney:roof_plate_diorite_smooth",
    ["chimney:chimney_trim_smooth_diorite"]       = "chimney:trim_diorite_smooth",

    ["chimney:chimney_andesite"]                  = "chimney:chimney_andesite",
    ["chimney:chimney_roof_plate_andesite"]       = "chimney:roof_plate_andesite",
    ["chimney:chimney_trim_andesite"]             = "chimney:trim_andesite",

    ["chimney:chimney_smooth_andesite"]           = "chimney:chimney_andesite_smooth",
    ["chimney:chimney_roof_plate_smooth_andesite"]= "chimney:roof_plate_andesite_smooth",
    ["chimney:chimney_trim_smooth_andesite"]      = "chimney:trim_andesite_smooth",
}

for old_node_name, new_node_name in pairs(old_chimney_nodes) do
    if core.registered_nodes[new_node_name] then
        minetest.register_alias(old_node_name, new_node_name)
    end
end
