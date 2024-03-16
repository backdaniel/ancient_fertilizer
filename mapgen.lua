local y_max = nil

if minetest.get_modpath("mcl_core") then
	y_max = y_max or 0
elseif minetest.get_modpath("default") then
	y_max = y_max or -255
end

local replace = {}

if minetest.get_modpath("default") then
	table.insert(replace, "default:stone")
	table.insert(replace, "default:stone_with_coal")
	table.insert(replace, "default:stone_with_iron")
	table.insert(replace, "default:stone_with_copper")
	table.insert(replace, "default:stone_with_tin")
	table.insert(replace, "default:stone_with_gold")
	table.insert(replace, "default:stone_with_diamond")
	table.insert(replace, "default:stone_with_mese")
end

if minetest.get_modpath("mcl_core") then
	table.insert(replace, "mcl_core:stone")
	table.insert(replace, "mcl_core:stone_with_coal")
	table.insert(replace, "mcl_core:stone_with_iron")
	table.insert(replace, "mcl_core:stone_with_gold")
end

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
	y_max           = y_max,
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
	y_max           = y_max,
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

minetest.register_ore({
	ore_type        = "blob",
	ore             = "ancient_fertilizer:ancient_stone",
	wherein         = replace,
	clust_scarcity  = 23 * 23 * 23,
	clust_size      = 8,
	y_max           = y_max,
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
