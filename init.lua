ancient_fertilizer = {}

ancient_fertilizer.MODNAME = minetest.get_current_modname()
ancient_fertilizer.MODPATH = minetest.get_modpath(ancient_fertilizer.MODNAME)

local S = minetest.get_translator(ancient_fertilizer.MODNAME)

dofile(ancient_fertilizer.MODPATH .. "/alias.lua")
dofile(ancient_fertilizer.MODPATH .. "/api.lua")
dofile(ancient_fertilizer.MODPATH .. "/compat.lua")

-- HELPERS

local function can_duplicate(node_name)
	return not ancient_fertilizer.is_disallowed(node_name) and (
		minetest.get_item_group(node_name, "flora") > 0 or
		minetest.get_item_group(node_name, "mushroom") > 0 or
		minetest.get_item_group(node_name, "sapling") > 0 or
		minetest.get_item_group(node_name, "can_duplicate") > 0
	)
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

minetest.register_node("ancient_fertilizer:ancient_stone", {
	description = S("Ancient Stone"),
	tiles = {"ancient_fertilizer_ancient_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "ancient_fertilizer:ancient_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ancient_fertilizer:ancient_cobble", {
	description = S("Ancient Cobblestone"),
	tiles = {"ancient_fertilizer_ancient_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ancient_fertilizer:ancient_stonebrick", {
	description = S("Ancient Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"ancient_fertilizer_ancient_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ancient_fertilizer:ancient_stone_block", {
	description = S("Ancient Stone Block"),
	tiles = {"ancient_fertilizer_ancient_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ancient_fertilizer:ancient_stone_cracked", {
	description = S("Cracked Ancient Stone"),
	tiles = {"ancient_fertilizer_ancient_stone_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ancient_fertilizer:ancient_stonebrick_cracked", {
	description = S("Cracked Ancient Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"ancient_fertilizer_ancient_stone_brick_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("ancient_fertilizer:fertilizer", {
	description = S("Ancient Fertilizer"),
	inventory_image = "ancient_fertilizer_fertilizer.png",
	on_use = function(itemstack, user, pointed_thing)
		if itemstack:is_empty() or not user or pointed_thing.type ~= "node" then
			return
		end
		local node = minetest.get_node(pointed_thing.under)
		if can_duplicate(node.name) then
			local drop = ancient_fertilizer.get_drop(node.name) or node.name
			if add_to_inventory(user, drop) and not is_creative(user:get_player_name()) then
				itemstack:take_item()
			end
		end
		return itemstack
	end
})

-- CRAFTS

minetest.register_craft({
	output = "ancient_fertilizer:ancient_stone_block 9",
	recipe = {
		{"ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone"},
		{"ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone"},
		{"ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone"},
	}
})

minetest.register_craft({
	output = "ancient_fertilizer:ancient_stonebrick 4",
	recipe = {
		{"ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone"},
		{"ancient_fertilizer:ancient_stone", "ancient_fertilizer:ancient_stone"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "ancient_fertilizer:ancient_stone",
	recipe = "ancient_fertilizer:ancient_cobble"
})

minetest.register_craft({
	type = "cooking",
	output = "ancient_fertilizer:ancient_stone_cracked",
	recipe = "ancient_fertilizer:ancient_stone"
})

minetest.register_craft({
	type = "cooking",
	output = "ancient_fertilizer:fertilizer 4",
	recipe = "ancient_fertilizer:ancient_stone_cracked"
})

minetest.register_craft({
	type = "cooking",
	output = "ancient_fertilizer:ancient_stonebrick_cracked",
	recipe = "ancient_fertilizer:ancient_stonebrick"
})

-- STAIRS

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"ancient_stone",
		"ancient_fertilizer:ancient_stone",
		{cracky = 3},
		{"ancient_fertilizer_ancient_stone.png"},
		S("Ancient Stone Stair"),
		S("Ancient Stone Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Ancient Stone Stair"),
		S("Outer Ancient Stone Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_cobble",
		"ancient_fertilizer:ancient_cobble",
		{cracky = 3},
		{"ancient_fertilizer_ancient_cobble.png"},
		S("Ancient Cobblestone Stair"),
		S("Ancient Cobblestone Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Ancient Cobblestone Stair"),
		S("Outer Ancient Cobblestone Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_stone_block",
		"ancient_fertilizer:ancient_stone_block",
		{cracky = 2},
		{"ancient_fertilizer_ancient_stone_block.png"},
		S("Ancient Stone Block Stair"),
		S("Ancient Stone Block Slab"),
		default.node_sound_stone_defaults(),
		true,
		S("Inner Ancient Stone Block Stair"),
		S("Outer Ancient Stone Block Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_stonebrick",
		"ancient_fertilizer:ancient_stonebrick",
		{cracky = 2},
		{"ancient_fertilizer_ancient_stone_brick.png"},
		S("Ancient Stone Brick Stair"),
		S("Ancient Stone Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Ancient Stone Brick Stair"),
		S("Outer Ancient Stone Brick Stair")
	)
	stairs.register_stair_and_slab(
		"ancient_stonebrick_cracked",
		"ancient_fertilizer:ancient_stonebrick_cracked",
		{cracky = 2},
		{"ancient_fertilizer_ancient_stone_brick_cracked.png"},
		S("Cracked Ancient Stone Brick Stair"),
		S("Cracked Ancient Stone Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Cracked Ancient Stone Brick Stair"),
		S("Outer Cracked Ancient Stone Brick Stair")
	)
end

-- WALLS

if minetest.get_modpath("walls") then
	walls.register(
		":walls:ancientcobble",
		S("Ancient Cobblestone Wall"),
		{"ancient_fertilizer_ancient_cobble.png"},
		"ancient_fertilizer:ancient_cobble",
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
	ore             = "ancient_fertilizer:ancient_stone",
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
	ore             = "ancient_fertilizer:ancient_stone",
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
	ore             = "ancient_fertilizer:ancient_stone",
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
