chimney = {}

local nodebox_chimney = {
    type = "fixed",
    fixed = {
        {-0.5,   -0.5, -0.5,  -0.375, 0.5,   0.5},
        { 0.375, -0.5, -0.5,   0.5,   0.5,   0.5},
        {-0.375, -0.5,  0.375, 0.375, 0.5,   0.5},
        {-0.375, -0.5, -0.5,   0.375, 0.5,  -0.375},
    }
}

local nodebox_roof_plate = {
    type = "fixed",
    fixed = {
        {-0.5,   -0.5, -0.5,  -0.375, 0,   0.5},
        { 0.375, -0.5, -0.5,   0.5,   0,   0.5},
        {-0.375, -0.5,  0.375, 0.375, 0,   0.5},
        {-0.375, -0.5, -0.5,   0.375, 0,  -0.375},

        {-0.375, -0, 0.375, 0.375, 0.5,     0.5},
        {-0.375, -0, -0.5,   0.375, 0.5,  -0.375},

        {-0.5,   0.5, -0.5,   0.5,   0.4, 0.5},
    }
}

local nodebox_trim = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, -0.375, 0.5, 0.5},
        {-0.375, -0.5, 0.375, 0.375, 0.5, 0.5},
        {-0.375, -0.5, -0.5, 0.375, 0.5, -0.375},
        {0.375, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5625, 0.3125, -0.5625, -0.5, 0.375, 0.5625},
        {0.5, 0.3125, -0.5625, 0.5625, 0.375, 0.5625},
        {-0.5, 0.3125, -0.5625, 0.5, 0.375, -0.5},
        {-0.5, 0.3125, 0.5, 0.5, 0.375, 0.5625},
        {-0.5, 0, 0.5, 0.5, 0.0625, 0.5625},
        {-0.5, 0, -0.5625, 0.5, 0.0625, -0.5},
        {0.5, 0, -0.5625, 0.5625, 0.0625, 0.5625},
        {-0.5625, 0, -0.5625, -0.5, 0.0625, 0.5625},
        {-0.625, 0.1875, -0.625, 0.625, 0.3125, -0.5},
        {-0.625, 0.1875, 0.5, 0.625, 0.3125, 0.625},
        {0.5, 0.1875, -0.5, 0.625, 0.3125, 0.5},
        {-0.625, 0.1875, -0.5, -0.5, 0.3125, 0.5},
    }
}

function chimney.register_chimney(chimney_name, chimney_def)
    local chimney_itemstring = "chimney:chimney_" .. chimney_name
    local roof_plate_itemstring = "chimney:roof_plate_" .. chimney_name
    local trim_itemstring = "chimney:trim_" .. chimney_name

    local material_node_def = minetest.registered_nodes[chimney_def.material]
    local chimney_texture = chimney_def.texture or material_node_def.tiles[1]
    local chimney_groups = {chimney = 1}
    for key, value in pairs(chimney_def.groups or {}) do
        chimney_groups[key] = value
    end
    local chimney_description = chimney_def.description or material_node_def.description or ""

    minetest.register_node(chimney_itemstring, {
        description = (chimney_description .. " Chimney"),
        groups = chimney_groups,
        _mcl_hardness = material_node_def._mcl_hardness or 0.6,
        _mcl_blast_resistance = material_node_def._mcl_blast_resistance or 0.6,
        paramtype = "light",
        drawtype = "nodebox",
        tiles = {chimney_texture},
        node_box = nodebox_chimney,
        sounds = material_node_def.sounds or {},
    })
    minetest.register_node(roof_plate_itemstring, {
        description = (chimney_description .. " Chimney roof plate"),
        groups = chimney_groups,
        _mcl_hardness = material_node_def._mcl_hardness or 0.6,
        _mcl_blast_resistance = material_node_def._mcl_blast_resistance or 0.6,
        paramtype = "light",
        drawtype = "nodebox",
        tiles = {chimney_texture},
        node_box = nodebox_roof_plate,
        sounds = material_node_def.sounds or {},
    })
    minetest.register_node(trim_itemstring, {
        description = (chimney_description .. " Chimney Trim"),
        groups = chimney_groups,
        _mcl_hardness = material_node_def._mcl_hardness or 0.6,
        _mcl_blast_resistance = material_node_def._mcl_blast_resistance or 0.6,
        paramtype = "light",
        drawtype = "nodebox",
        tiles = {chimney_texture},
        node_box = nodebox_trim,
        sounds = material_node_def.sounds or {},
    })

    minetest.register_craft({
        output = chimney_itemstring .. " 4",
        recipe = {
            {chimney_def.material, "", chimney_def.material},
            {chimney_def.material, "", chimney_def.material},
            {chimney_def.material, "", chimney_def.material},
        },
    })
    minetest.register_craft({
        output = roof_plate_itemstring .. " 2",
        recipe = {
            {chimney_def.material},
            {chimney_itemstring},
        },
    })
    minetest.register_craft({
        output = trim_itemstring .. " 2",
        recipe = {
            {chimney_def.material, chimney_itemstring, chimney_def.material},
        },
    })
end

dofile(minetest.get_modpath("chimney") .. "/register.lua")
dofile(minetest.get_modpath("chimney") .. "/compatibility.lua")
