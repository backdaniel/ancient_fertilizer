basalt_fertilizer = {}

-- HELPERS


  ["farming:seed_cotton"] = true,
  ["farming:cotton_1"] = true,
  ["farming:cotton_2"] = true,
  ["farming:cotton_3"] = true,
  ["farming:cotton_4"] = true,
  ["farming:cotton_5"] = true,
  ["farming:cotton_6"] = true,
  ["farming:cotton_7"] = true,
  ["farming:cotton_8"] = true,
}

local crops_progression = {
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

function next_stage(node_name)
  return crops_progression[node_name]
end

-- NODES

minetest.register_node("basalt_fertilizer:basalt", {
  description = "Basalt",
  tiles = {"node_basalt.png"},
  groups = {cracky = 3, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_block", {
  description = "Basalt Block",
  tiles = {"node_basalt_block.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_brick", {
  description = "Basalt Brick",
  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {"node_basalt_brick.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("basalt_fertilizer:fertilizer", {
  description = "Fertilizer",
  inventory_image = "item_fertilizer.png"

  on_use = function(itemstack, user, pointed_thing)
    if pointed_thing.type ~= "node" then
      return
    end
    local node = minetest.get_node(pointed_thing.under)
    local next_stage_node = next_stage(node.name)
    if next_stage_node and not itemstack:is_empty() and user then
      minetest.set_node(pointed_thing.under, {name = next_stage_node})
      itemstack:take_item()
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
  output = "basalt_fertilizer:fertilizer",
  recipe = {{"basalt_fertilizer:basalt"}}
})

-- STAIRS

if minetest.get_modpath("stairs") then

  stairs.register_stair_and_slab(
    "basalt",
    "basalt_fertilizer:basalt",
    {cracky = 3},
    {"node_basalt.png"},
    "Basalt Stair",
    "Basalt Slab",
    default.node_sound_stone_defaults(),
    true
  )

  stairs.register_stair_and_slab(
    "basalt_brick",
    "basalt_fertilizer:basalt_brick",
    {cracky = 2},
    {"node_basalt_brick.png"},
    "Basalt Brick Stair",
    "Basalt Brick Slab",
    default.node_sound_stone_defaults(),
    false
  )

  stairs.register_stair_and_slab(
    "basalt_block",
    "basalt_fertilizer:basalt_block",
    {cracky = 2},
    {"node_basalt_block.png"},
    "Basalt Block Stair",
    "Basalt Block Slab",
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
