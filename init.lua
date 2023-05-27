basalt_fertilizer = {}

local S = minetest.get_translator("basalt_fertilizer")

-- HELPERS

local crops = {
  ["farming:seed_wheat"] = "farming:wheat_1",
  ["farming:wheat_1"] = "farming:wheat_2",
  ["farming:wheat_2"] = "farming:wheat_3",
  ["farming:wheat_3"] = "farming:wheat_4",
  ["farming:wheat_4"] = "farming:wheat_5",
  ["farming:wheat_5"] = "farming:wheat_6",
  ["farming:wheat_6"] = "farming:wheat_7",
  ["farming:wheat_7"] = "farming:wheat_8",
  ["farming:seed_cotton"] = "farming:cotton_1",
  ["farming:cotton_1"] = "farming:cotton_2",
  ["farming:cotton_2"] = "farming:cotton_3",
  ["farming:cotton_3"] = "farming:cotton_4",
  ["farming:cotton_4"] = "farming:cotton_5",
  ["farming:cotton_5"] = "farming:cotton_6",
  ["farming:cotton_6"] = "farming:cotton_7",
  ["farming:cotton_7"] = "farming:cotton_8",
}

local saplings = {
  ["default:sapling"] = minetest.get_modpath("default") .. "/schematics/apple_tree.mts",
  ["default:junglesapling"] = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
  ["default:pine_sapling"] = minetest.get_modpath("default") .. "/schematics/pine_tree.mts",
  ["default:acacia_sapling"] = minetest.get_modpath("default") .. "/schematics/acacia_tree.mts",
  ["default:aspen_sapling"] = minetest.get_modpath("default") .. "/schematics/aspen_tree.mts",
  ["default:bush_sapling"] = minetest.get_modpath("default") .. "/schematics/bush.mts",
  ["default:acacia_bush_sapling"] = minetest.get_modpath("default") .. "/schematics/acacia_bush.mts",
  ["default:pine_bush_sapling"] = minetest.get_modpath("default") .. "/schematics/pine_bush.mts",
  ["default:blueberry_bush_sapling"] = minetest.get_modpath("default") .. "/schematics/blueberry_bush.mts",
  ["default:emergent_jungle_sapling"] = minetest.get_modpath("default") .. "/schematics/emergent_jungle_tree.mts",
}

function isCreative(player_name)
  local player_privs = minetest.get_player_privs(player_name)
  return player_privs.creative or minetest.is_creative_enabled(player_name)
end


-- NODES

minetest.register_node("basalt_fertilizer:basalt", {
  description = S("Basalt"),
  tiles = {"node_basalt.png"},
  groups = {cracky = 3, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_block", {
  description = S("Basalt Block"),
  tiles = {"node_basalt_block.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_brick", {
  description = S("Basalt Brick"),
  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {"node_basalt_brick.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("basalt_fertilizer:fertilizer", {
  description = S("Mineral Fertilizer"),
  inventory_image = "item_fertilizer.png",
  on_use = function(itemstack, user, pointed_thing)
    if pointed_thing.type ~= "node" then
      return
    end
    
    local node = minetest.get_node(pointed_thing.under)
    if crops[node.name] and not itemstack:is_empty() and user then
      minetest.set_node(pointed_thing.under, {name = crops[node.name]})
      if not isCreative(user:get_player_name()) then
        itemstack:take_item()
      end
    end
    if saplings[node.name] and not itemstack:is_empty() and user then
      minetest.remove_node(pointed_thing.under)
      minetest.place_schematic({x=pointed_thing.under.x, y=pointed_thing.under.y-1, z=pointed_thing.under.z}, saplings[node.name], "random", {}, false, "place_center_x,place_center_z")
      if not isCreative(user:get_player_name()) then
        itemstack:take_item()
      end
    end
    return itemstack
  end
})

-- CRAFTS

minetest.register_craft({
  output = "basalt_fertilizer:basalt_brick 4",
  recipe = {
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
  }
})

minetest.register_craft({
  output = "basalt_fertilizer:basalt_block 9",
  recipe = {
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
  }
})

minetest.register_craft({
  output = "basalt_fertilizer:fertilizer 4",
  recipe = {{"basalt_fertilizer:basalt"}}
})

minetest.register_craft({
  output = "basalt_fertilizer:basalt",
  recipe = {
    {"basalt_fertilizer:fertilizer", "basalt_fertilizer:fertilizer"},
    {"basalt_fertilizer:fertilizer", "basalt_fertilizer:fertilizer"},
  }
})

-- STAIRS

if minetest.get_modpath("stairs") then

  stairs.register_stair_and_slab(
    "basalt",
    "basalt_fertilizer:basalt",
    {cracky = 3},
    {"node_basalt.png"},
    S("Basalt Stair"),
    S("Basalt Slab"),
    default.node_sound_stone_defaults(),
    true
  )

  stairs.register_stair_and_slab(
    "basalt_brick",
    "basalt_fertilizer:basalt_brick",
    {cracky = 2},
    {"node_basalt_brick.png"},
    S("Basalt Brick Stair"),
    S("Basalt Brick Slab"),
    default.node_sound_stone_defaults(),
    false
  )

  stairs.register_stair_and_slab(
    "basalt_block",
    "basalt_fertilizer:basalt_block",
    {cracky = 2},
    {"node_basalt_block.png"},
    S("Basalt Block Stair"),
    S("Basalt Block Slab"),
    default.node_sound_stone_defaults(),
    true
  )

end

-- MAPGEN

minetest.register_ore({
  ore_type        = "blob",
  ore             = "basalt_fertilizer:basalt",
  wherein         = {"default:stone"},
  clust_scarcity  = 16 * 16 * 16,
  clust_size      = 5,
  y_max           = 0,
  y_min           = -31000,
  noise_threshold = 0.0,
  noise_params    = {
    offset = 0.5,
    scale = 0.2,
    spread = {x = 5, y = 5, z = 5},
    seed = 111,
    octaves = 1,
    persist = 0.0
  },
})
