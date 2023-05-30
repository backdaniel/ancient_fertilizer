if minetest.get_modpath("default") then
  basalt_fertilizer.add_vegetation({
    ["default:grass_1"] = "default:grass_1",
    ["default:grass_2"] = "default:grass_1",
    ["default:grass_3"] = "default:grass_1",
    ["default:grass_4"] = "default:grass_1",
    ["default:grass_5"] = "default:grass_1",
    ["default:dry_grass_1"] = "default:dry_grass_1",
    ["default:dry_grass_2"] = "default:dry_grass_1",
    ["default:dry_grass_3"] = "default:dry_grass_1",
    ["default:dry_grass_4"] = "default:dry_grass_1",
    ["default:dry_grass_5"] = "default:dry_grass_1",
    ["default:fern_1"] = "default:fern_1",
    ["default:fern_2"] = "default:fern_1",
    ["default:fern_3"] = "default:fern_1",
    ["default:marram_grass_1"] = "default:marram_grass_1",
    ["default:marram_grass_2"] = "default:marram_grass_1",
    ["default:marram_grass_3"] = "default:marram_grass_1",
    ["default:junglegrass"] = "default:junglegrass",
    ["default:dry_shrub"] = "default:dry_shrub",
    ["default:sapling"] = "default:sapling",
    ["default:junglesapling"] = "default:junglesapling",
    ["default:pine_sapling"] = "default:pine_sapling",
    ["default:acacia_sapling"] = "default:acacia_sapling",
    ["default:aspen_sapling"] = "default:aspen_sapling",
    ["default:bush_sapling"] = "default:bush_sapling",
    ["default:acacia_bush_sapling"] = "default:acacia_bush_sapling",
    ["default:pine_bush_sapling"] = "default:pine_bush_sapling",
    ["default:blueberry_bush_sapling"] = "default:blueberry_bush_sapling",
    ["default:emergent_jungle_sapling"] = "default:emergent_jungle_sapling",
    ["default:large_cactus_seedling"] = "default:large_cactus_seedling",
    ["default:sand_with_kelp"] = "default:sand_with_kelp",
    ["default:coral_cyan"] = "default:coral_cyan",
    ["default:coral_green"] = "default:coral_green",
    ["default:coral_pink"] = "default:coral_pink",
  })
end

if minetest.get_modpath("flowers") then
  basalt_fertilizer.add_vegetation({
    ["flowers:dandelion_white"] = "flowers:dandelion_white",
    ["flowers:tulip_black"] = "flowers:tulip_black",
    ["flowers:chrysanthemum_green"] = "flowers:chrysanthemum_green",
    ["flowers:dandelion_yellow"] = "flowers:dandelion_yellow",
    ["flowers:tulip"] = "flowers:tulip",
    ["flowers:geranium"] = "flowers:geranium",
    ["flowers:viola"] = "flowers:viola",
    ["flowers:rose"] = "flowers:rose",
    ["flowers:mushroom_red"] = "flowers:mushroom_red",
    ["flowers:mushroom_brown"] = "flowers:mushroom_brown",
    ["flowers:waterlily"] = "flowers:waterlily",
    ["flowers:waterlily_waving"] = "flowers:waterlily",
  })
end

if minetest.get_modpath("farming") then
  basalt_fertilizer.add_vegetation({
    ["farming:cotton_wild"] = "farming:cotton_wild",
  })
end
