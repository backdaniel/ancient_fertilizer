basalt_fertilizer = {}

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
  clust_scarcity  = 44 * 44 * 44,
  clust_size      = 11,
  y_max           = 31000,
  y_min           = -31000,
  noise_threshold = 0.0,
  noise_params    = {
    offset = 0.5,
    scale = 0.2,
    spread = {x = 6, y = 6, z = 3},
    seed = 111,
    octaves = 1,
    persist = 0.0
  },
})
