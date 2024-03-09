basalt_fertilizer = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local S = minetest.get_translator(modname)

-- HELPERS

local function can_duplicate(item_name)
	return minetest.get_item_group(item_name, "group:flora") > 0
		or minetest.get_item_group(item_name, "group:mushroom") > 0
		or minetest.get_item_group(item_name, "group:sapling") > 0
		or minetest.get_item_group(item_name, "group:can_duplicate") > 0
end

local function add_to_inventory(user, item_name)
	local inv = user:get_inventory()
	local stack_max = ItemStack(item_name):get_stack_max()
	for i = 1, inv:get_size('main') do
		local stack = inv:get_stack('main', i)
		if stack:get_name() == item_name and stack:get_count() < stack_max then
			inv:add_item('main', ItemStack(item_name))
			return true
		end
	end
	if inv:room_for_item('main', ItemStack(item_name)) then
		inv:add_item('main', ItemStack(item_name))
		return true
	end
	return false
end

local function is_creative(player_name)
	local player_privs = minetest.get_player_privs(player_name)
	return player_privs.creative or minetest.is_creative_enabled(player_name)
end

-- DEFINITIONS

minetest.register_node("basalt_fertilizer:basalt", {
	description = S("Ancient Basalt"),
	tiles = {"node_basalt.png"},
	groups = {cracky = 3, stone = 1},
	drop = "basalt_fertilizer:basalt_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_cobble", {
	description = S("Cobbled Ancient Basalt"),
	tiles = {"node_basalt_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_brick", {
	description = S("Ancient Basalt Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"node_basalt_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_block", {
	description = S("Ancient Basalt Block"),
	tiles = {"node_basalt_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_cracked", {
	description = S("Cracked Ancient Basalt"),
	tiles = {"node_basalt_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_cracked_brick", {
	description = S("Cracked Ancient Basalt Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"node_basalt_cracked_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("basalt_fertilizer:fertilizer", {
	description = S("Ancient Fertilizer"),
	inventory_image = "item_fertilizer.png",
	on_use = function(itemstack, user, pointed_thing)
		if itemstack:is_empty() or not user or pointed_thing.type ~= "node" then
			return
		end
		local node = minetest.get_node(pointed_thing.under)
		if can_duplicate(node.name) then
			if add_to_inventory(user, node.name) and not is_creative(user:get_player_name()) then
				itemstack:take_item()
			end
		end
		return itemstack
	end
})

-- CRAFTS

minetest.register_craft({
	output = "basalt_fertilizer:basalt_block 9",
	recipe = {
		{"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
		{"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
		{"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
	}
})

minetest.register_craft({
	output = "basalt_fertilizer:basalt_brick 4",
	recipe = {
		{"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
		{"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "basalt_fertilizer:basalt",
	recipe = "basalt_fertilizer:basalt_cobble"
})

minetest.register_craft({
	type = "cooking",
	output = "basalt_fertilizer:basalt_cracked",
	recipe = "basalt_fertilizer:basalt"
})

minetest.register_craft({
	type = "cooking",
	output = "basalt_fertilizer:fertilizer",
	recipe = "basalt_fertilizer:basalt_cracked"
})

minetest.register_craft({
	type = "cooking",
	output = "basalt_fertilizer:basalt_cracked_brick",
	recipe = "basalt_fertilizer:basalt_brick"
})

-- STAIRS

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"ancient_basalt",
		"basalt_fertilizer:basalt",
		{cracky = 3},
		{"node_basalt.png"},
		S("Ancient Basalt Stair"),
		S("Ancient Basalt Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Ancient Basalt Stair"),
		S("Outer Ancient Basalt Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_basalt_cobble",
		"basalt_fertilizer:basalt_cobble",
		{cracky = 3},
		{"node_basalt_cobble.png"},
		S("Cobbled Ancient Basalt Stair"),
		S("Cobbled Ancient Basalt Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Cobbled Ancient Basalt Stair"),
		S("Outer Cobbled Ancient Basalt Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_basalt_block",
		"basalt_fertilizer:basalt_block",
		{cracky = 2},
		{"node_basalt_block.png"},
		S("Ancient Basalt Block Stair"),
		S("Ancient Basalt Block Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Ancient Basalt Block Stair"),
		S("Outer Ancient Basalt Block Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_basalt_brick",
		"basalt_fertilizer:basalt_brick",
		{cracky = 2},
		{"node_basalt_brick.png"},
		S("Ancient Basalt Brick Stair"),
		S("Ancient Basalt Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Ancient Basalt Brick Stair"),
		S("Outer Ancient Basalt Brick Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_basalt_cracked_brick",
		"basalt_fertilizer:basalt_cracked_brick",
		{cracky = 2},
		{"node_basalt_cracked_brick.png"},
		S("Cracked Ancient Basalt Brick Stair"),
		S("Cracked Ancient Basalt Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Cracked Ancient Basalt Brick Stair"),
		S("Outer Cracked Ancient Basalt Brick Stair")
	)
end

-- WALLS

if minetest.get_modpath("walls") then
	walls.register(
		"basalt_fertilizer:ancient_basalt_cobble_wall",
		S("Cobbled Ancient Basalt Wall"),
		{"node_basalt_cobble.png"},
		"basalt_fertilizer:basalt_cobble",
		default.node_sound_stone_defaults()
	)
end

-- MAPGEN

local replace = {
	"default:stone",
	"default:stone_with_coal",
	"default:stone_with_iron",
	"default:stone_with_copper",
	"default:stone_with_tin",
	"default:stone_with_gold",
	"default:stone_with_diamond",
	"default:stone_with_mese",
}

if minetest.get_modpath("moreores") then
	table.insert(replace, "moreores:mineral_silver")
	table.insert(replace, "moreores:mineral_mithril")
end

minetest.register_ore({
	ore_type        = "blob",
	ore             = "basalt_fertilizer:basalt",
	wherein         = replace,
	clust_scarcity  = 23 * 23 * 23,
	clust_size      = 4,
	y_max           = -255,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 349638245,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "basalt_fertilizer:basalt",
	wherein         = replace,
	clust_scarcity  = 23 * 23 * 23,
	clust_size      = 5,
	y_max           = -255,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 625867536,
		octaves = 1,
		persist = 0.0
	},
})

table.insert(replace, "default:silver_sand")
table.insert(replace, "default:gravel")

minetest.register_ore({
	ore_type        = "blob",
	ore             = "basalt_fertilizer:basalt",
	wherein         = replace,
	clust_scarcity  = 23 * 23 * 23,
	clust_size      = 8,
	y_max           = -255,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 266558522,
		octaves = 1,
		persist = 0.0
	},
})
