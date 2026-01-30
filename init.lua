local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)
local S = core.get_translator(modname)

chimneys = {}

local directions = {
	{x = 1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = -1, y = 0, z = 0},
	{x = 0, y = 0, z = -1},
}

local function connectable(itemstring)
	return core.get_item_group(itemstring, "chimney") == 1
end

function chimneys.update_chimney(pos)
	local thisnode = core.get_node(pos)

	if core.get_item_group(thisnode.name, "chimney") == 0 then
		return
	end

	-- Get the node's base name, including the underscore since we will need it
	local colonpos = thisnode.name:find(":")
	local underscorepos
	local itemname, basename, modname
	if colonpos then
		itemname = thisnode.name:sub(colonpos+1)
		modname = thisnode.name:sub(1, colonpos-1)
	end
	underscorepos = itemname:find("_")
	if underscorepos == nil then -- New chimney
		basename = thisnode.name .. "_"
	else -- Already placed chimney
		basename = modname .. ":" .. itemname:sub(1, underscorepos)
	end

	local sum = 0

	-- Neighbouring walkable nodes
	for i = 1, 4 do
		local dir = directions[i]
		local node = core.get_node({x = pos.x + dir.x, y = pos.y + dir.y, z = pos.z + dir.z})
		if connectable(node.name) then
			sum = sum + 2 ^ (i - 1)
		end
	end

	--[[if sum == 0 then
		sum = 15
	end]]

	core.set_node(pos, {name = basename..sum})
end

-- XXX: render this asynchronous and move it into nodeprops.lua.
local level_to_minetest_position = mcl_levelgen.level_to_minetest_position
local update_chimney = chimneys.update_chimney
local v = vector.zero ()

mcl_levelgen.register_notification_handler ("chimneys:update_chimneys", function (_, data)
	for _, pos in ipairs (data) do
		local x, y, z = level_to_minetest_position (pos.x, pos.y, pos.z)
		v.x = x
		v.y = y
		v.z = z
		update_chimney (v)
	end
end)

local function update_chimney_global(pos)
	for i = 1,4 do
		local dir = directions[i]
		chimneys.update_chimney({x = pos.x + dir.x, y = pos.y + dir.y, z = pos.z + dir.z})
	end
end

local corners = {
    {-0.5, -0.5, -0.5, -3/8, 0.5, -3/8},
    {-0.5, -0.5,  0.5, -3/8, 0.5,  3/8},
    { 0.5, -0.5,  0.5,  3/8, 0.5,  3/8},
    { 0.5, -0.5, -0.5,  3/8, 0.5, -3/8},
}

local sides = {
    { 0.5, -0.5,  0.5,  3/8, 0.5, -3/8},
    {-0.5, -0.5,  0.5,  3/8, 0.5,  3/8},
    {-0.5, -0.5, -0.5, -3/8, 0.5,  3/8},
    { 0.5, -0.5, -0.5, -3/8, 0.5, -3/8},
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

local function rshift(x, by)
	return math.floor(x / 2 ^ by) % 2
end

--[[ Adds a new chimney type.
* nodename: Itemstring of base node to add. Must not contain an underscore
* description: Item description (tooltip), visible to user
* source: Source block to craft this thing, for graphics, tiles and crafting (optional)
* tiles: Wall textures table
* inventory_image: Inventory image (optional)
* groups: Base group memberships (optional, default is {pickaxey=1})
* sounds: Sound table (optional, default is stone)
]]
function chimneys.register_chimney(nodename, description, source, tiles, inventory_image, groups, sounds, overrides)
	local base_groups = groups
	if not base_groups then
		base_groups = {pickaxey=1}
	end
	base_groups.chimney = 1

	local internal_groups = table.copy(base_groups)
	internal_groups.not_in_creative_inventory = 1

	local main_node_groups = table.copy(base_groups)
	main_node_groups.deco_block = 1

	if not sounds then
		sounds = mcl_sounds.node_sound_stone_defaults()
	end

	if (not tiles) and source then
		if core.registered_nodes[source] then
			tiles = core.registered_nodes[source].tiles
		end
	end

	for i = 0, 15 do
		local shape = {}
        for j = 1, 4 do
            table.insert(shape, corners[j])
        end

        -- We want the inverse of the bits 0 is full chimney, 15 is the center of a plus
        for k = 1, 4 do
            if rshift(i, k - 1) % 2 == 0 then
                table.insert(shape, sides[k])
            end
        end

		core.register_node(nodename.."_"..i, table.merge({
			collision_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
			},
			drawtype = "nodebox",
			is_ground_content = false,
			tiles = tiles,
			paramtype = "light",
			sunlight_propagates = true,
			groups = internal_groups,
			drop = nodename,
			node_box = {
				type = "fixed",
				fixed = shape
			},
			sounds = sounds,
			_mcl_blast_resistance = 6,
			_mcl_hardness = 2,
			_mcl_stonecutter_recipes = {source},
			_mcl_baseitem = nodename,
		}, overrides or {}))

		doc.add_entry_alias("nodes", nodename, "nodes", nodename.."_"..i)

        if i == 0 then
            -- Inventory item
            core.register_node(nodename, table.merge({
                description = description,
                _doc_items_longdesc = S("A piece of chimney. When multiple of these are placed to next to each other, they will automatically build a wider chimney structure."),
                paramtype = "light",
                sunlight_propagates = true,
                is_ground_content = false,
                groups = main_node_groups,
                tiles = tiles,
                inventory_image = inventory_image,
                drawtype = "nodebox",
                node_box = {
                    type = "fixed",
                    fixed = shape
                },
                collision_box = {
                        type = "fixed",
                        fixed = shape
                },
                collisionbox = {-0.2, 0, -0.2, 0.2, 1.4, 0.2},
                on_construct = chimneys.update_chimney,
                sounds = sounds,
                _mcl_blast_resistance = 6,
                _mcl_hardness = 2,
            }, overrides or {}))
        end
	end

	if source then
		core.register_craft({
			output = nodename .. " 6",
			recipe = {
				{source, "", source},
				{source, "", source},
                {source, "", source}
			}
		})
	end
end

function chimneys.register_chimney_def(name,def)
	local source = def.source
	def.source = nil
	chimneys.register_chimney(name, nil, source, nil, nil, nil, nil, def)
end

dofile(modpath.."/register.lua")

core.register_on_placenode(update_chimney_global)
core.register_on_dignode(update_chimney_global)
