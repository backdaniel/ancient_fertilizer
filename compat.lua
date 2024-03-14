if minetest.get_modpath("default") then
	ancient_fertilizer.add_node("default:large_cactus_seedling")
	ancient_fertilizer.add_node("default:sand_with_kelp")
end

if minetest.get_modpath("flowers") then
	ancient_fertilizer.override_drop("flowers:waterlily_waving", "flowers:waterlily")
end

if minetest.get_modpath("farming") then
	ancient_fertilizer.add_node("farming:cotton_wild")
end

if minetest.get_modpath("mcl_flowers") then
	ancient_fertilizer.add_node("mcl_flowers:tallgrass")
	ancient_fertilizer.has_variations("mcl_flowers:double_grass", "mcl_flowers:double_grass")
	ancient_fertilizer.add_node("mcl_flowers:fern")
	ancient_fertilizer.has_variations("mcl_flowers:double_fern", "mcl_flowers:double_fern")
	ancient_fertilizer.add_node("mcl_flowers:waterlily")
end

if minetest.get_modpath("mcl_ocean") then
	ancient_fertilizer.has_variations("mcl_ocean:seagrass_", "mcl_ocean:seagrass")
	ancient_fertilizer.has_variations("mcl_ocean:kelp_", "mcl_ocean:kelp")
end
