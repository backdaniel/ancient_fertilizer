if minetest.get_modpath("default") then
	ancient_fertilizer.has_variations("default:grass_", "default:grass_1")
	ancient_fertilizer.has_variations("default:dry_grass_", "default:dry_grass_1")
	ancient_fertilizer.has_variations("default:fern_", "default:fern_1")
	ancient_fertilizer.has_variations("default:marram_grass_", "default:marram_grass_1")
	ancient_fertilizer.add_node("default:large_cactus_seedling")
end

if minetest.get_modpath("flowers") then
	ancient_fertilizer.override_drop("flowers:waterlily_waving", "flowers:waterlily")
end

if minetest.get_modpath("farming") then
	ancient_fertilizer.add_node("farming:cotton_wild")
end
