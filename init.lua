basalt_fertilizer = {}

local S = minetest.get_translator("basalt_fertilizer")

-- HELPERS

local vegetation = {
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
  ["farming:cotton_wild"] = "farming:cotton_wild",
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
}


function isCreative(player_name)
  local player_privs = minetest.get_player_privs(player_name)
  return player_privs.creative or minetest.is_creative_enabled(player_name)
end

function add_to_inventory(user, item_name)
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
    if vegetation[node.name] and not itemstack:is_empty() and user then
      if add_to_inventory(user, vegetation[node.name]) and not isCreative(user:get_player_name()) then
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
