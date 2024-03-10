ancient_fertilizer.DEFAULT_GROUPS = {}

if minetest.get_modpath("mcl_core") then
	ancient_fertilizer.DEFAULT_GROUPS = {
		flower = true
	}
elseif minetest.get_modpath("default") then
	ancient_fertilizer.DEFAULT_GROUPS = {
		flora = true,
		mushroom = true,
		sapling = true
	}
end
