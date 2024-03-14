ancient_fertilizer = {}

ancient_fertilizer.MODNAME = minetest.get_current_modname()
ancient_fertilizer.MODPATH = minetest.get_modpath(ancient_fertilizer.MODNAME)

local S = minetest.get_translator(ancient_fertilizer.MODNAME)

dofile(ancient_fertilizer.MODPATH .. "/alias.lua")
dofile(ancient_fertilizer.MODPATH .. "/api.lua")
dofile(ancient_fertilizer.MODPATH .. "/compat.lua")

-- HELPERS

local function add_to_inventory(user, item_name)
	local inv = user:get_inventory()
	local stack = ItemStack(item_name)
	local leftover = inv:add_item('main', stack)
	return leftover:is_empty()
end

local function is_creative(player_name)
	return minetest.check_player_privs(player_name, {creative=true})
	    or minetest.is_creative_enabled(player_name)
end

-- SOUNDS

local function get_stone_sounds()
	if minetest.get_modpath("mcl_sounds") then
			return mcl_sounds.node_sound_stone_defaults()
	elseif minetest.get_modpath("default") then
			return default.node_sound_stone_defaults()
	end
end

local stone_sounds = get_stone_sounds()

-- DEFINITIONS

minetest.register_node("ancient_fertilizer:ancient_stone", {
	description = S("Ancient Stone"),
	tiles = {"ancient_fertilizer_ancient_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "ancient_fertilizer:ancient_cobble",
	sounds = stone_sounds,
})

minetest.register_node("ancient_fertilizer:ancient_cobble", {
	description = S("Ancient Cobblestone"),
	tiles = {"ancient_fertilizer_ancient_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = stone_sounds,
})

minetest.register_node("ancient_fertilizer:ancient_stonebrick", {
	description = S("Ancient Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"ancient_fertilizer_ancient_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone_sounds,
})

minetest.register_node("ancient_fertilizer:ancient_stone_block", {
	description = S("Ancient Stone Block"),
	tiles = {"ancient_fertilizer_ancient_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone_sounds,
})

minetest.register_node("ancient_fertilizer:ancient_stone_cracked", {
	description = S("Cracked Ancient Stone"),
	tiles = {"ancient_fertilizer_ancient_stone_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone_sounds,
})

minetest.register_node("ancient_fertilizer:ancient_stonebrick_cracked", {
	description = S("Cracked Ancient Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"ancient_fertilizer_ancient_stone_brick_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone_sounds,
})

minetest.register_craftitem("ancient_fertilizer:fertilizer", {
	description = S("Ancient Fertilizer"),
	inventory_image = "ancient_fertilizer_fertilizer.png",
	on_use = function(itemstack, user, pointed_thing)
		if itemstack:is_empty() or not user or pointed_thing.type ~= "node" then
			return
		end
		local node = minetest.get_node(pointed_thing.under)
		if ancient_fertilizer.should_affect(node.name) then
			local drop = ancient_fertilizer.get_drop(node.name)
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
		stone_sounds,
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
		stone_sounds,
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
		stone_sounds,
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
		stone_sounds,
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
		stone_sounds,
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
		stone_sounds
	)
end

dofile(ancient_fertilizer.MODPATH .. "/mapgen.lua")
