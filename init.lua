basalt_fertilizer = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local S = minetest.get_translator(modname)

-- API

dofile(modpath .. "/api.lua")

-- HELPERS

local function is_creative(player_name)
  local player_privs = minetest.get_player_privs(player_name)
  return player_privs.creative or minetest.is_creative_enabled(player_name)
end

local function add_to_inventory(user, item_name)
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

-- DEFINITIONS

local other_basalt_mods = {
  "too_many_stones",
  "amethyst_new",
}

local stone_name = "Basalt"
for _, mod_name in ipairs(other_basalt_mods) do
  if minetest.get_modpath(mod_name) then
    stone_name = "Ancient Basalt"
    break
  end
end

minetest.register_node("basalt_fertilizer:basalt", {
  description = S(stone_name),
  tiles = {"node_basalt.png"},
  groups = {cracky = 3, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_block", {
  description = S(stone_name .. " Block"),
  tiles = {"node_basalt_block.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_brick", {
  description = S(stone_name .. " Brick"),
  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {"node_basalt_brick.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basalt_fertilizer:basalt_cracked_brick", {
  description = S("Cracked " .. stone_name .. " Brick"),
  paramtype2 = "facedir",
  place_param2 = 0,
  tiles = {"node_basalt_cracked_brick.png"},
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
    local vegetation = basalt_fertilizer.get_vegetation(node.name)
    if vegetation and not itemstack:is_empty() and user then
      if add_to_inventory(user, vegetation) and not is_creative(user:get_player_name()) then
        itemstack:take_item()
      end
    end
    return itemstack
  end
})

-- CRAFTS

minetest.register_craft({
  output = "basalt_fertilizer:basalt_block 9",
  recipe = {
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
  }
})

minetest.register_craft({
  output = "basalt_fertilizer:basalt_brick 4",
  recipe = {
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
    {"basalt_fertilizer:basalt", "basalt_fertilizer:basalt"},
  }
})

minetest.register_craft({
  type = "cooking",
  output = "basalt_fertilizer:basalt_cracked_brick",
  recipe = "basalt_fertilizer:basalt_brick"
})

minetest.register_craft({
  type = "cooking",
  output = "basalt_fertilizer:fertilizer",
  recipe = "basalt_fertilizer:basalt"
})

if minetest.get_modpath("stairs") then
  stairs.register_stair_and_slab(
    "basalt",
    "basalt_fertilizer:basalt",
    {cracky = 3},
    {"node_basalt.png"},
    S(stone_name .. " Stair"),
    S(stone_name .. " Slab"),
    default.node_sound_stone_defaults(),
    true
  )
  stairs.register_stair_and_slab(
    "basalt_block",
    "basalt_fertilizer:basalt_block",
    {cracky = 2},
    {"node_basalt_block.png"},
    S(stone_name .. " Block Stair"),
    S(stone_name .. " Block Slab"),
    default.node_sound_stone_defaults(),
    true
  )
  stairs.register_stair_and_slab(
    "basalt_brick",
    "basalt_fertilizer:basalt_brick",
    {cracky = 2},
    {"node_basalt_brick.png"},
    S(stone_name .. " Brick Stair"),
    S(stone_name .. " Brick Slab"),
    default.node_sound_stone_defaults(),
    false
  )
  stairs.register_stair_and_slab(
    "basalt_cracked_brick",
    "basalt_fertilizer:basalt_cracked_brick",
    {cracky = 2},
    {"node_basalt_cracked_brick.png"},
    S("Cracked " .. stone_name .. " Brick Stair"),
    S("Cracked " .. stone_name .. " Brick Slab"),
    default.node_sound_stone_defaults(),
    false
  )
end

-- MAPGEN

local replace = {
  "default:stone",
  "default:stone_with_coal",
  "default:stone_with_iron",
  "default:stone_with_copper",
  "default:stone_with_tin",
  "default:stone_with_gold",
  "default:stone_with_diamond",
  "default:stone_with_mese",
}

if minetest.get_modpath("moreores") then
  table.insert(replace, "moreores:mineral_silver")
  table.insert(replace, "moreores:mineral_mithril")
end

minetest.register_ore({
  ore_type        = "blob",
  ore             = "basalt_fertilizer:basalt",
  wherein         = replace,
  clust_scarcity  = 23 * 23 * 23,
  clust_size      = 4,
  y_max           = -255,
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
  ore             = "basalt_fertilizer:basalt",
  wherein         = replace,
  clust_scarcity  = 23 * 23 * 23,
  clust_size      = 5,
  y_max           = -255,
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

table.insert(replace, "default:silver_sand")
table.insert(replace, "default:gravel")

minetest.register_ore({
  ore_type        = "blob",
  ore             = "basalt_fertilizer:basalt",
  wherein         = replace,
  clust_scarcity  = 23 * 23 * 23,
  clust_size      = 8,
  y_max           = -255,
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
