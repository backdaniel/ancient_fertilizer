local can_duplicate = {}
local disallowed = {}
local overrides = {}
local variations = {}

local default_groups = {
	flower = true,
	flora = true,
	mushroom = true,
	sapling = true
}

local state_cache = {}
local drops_cache = {}

-- API: check compat.lua for examples

function ancient_fertilizer.add_node(node_name, drop_name)
	-- nodes you want to be able to duplicate
	-- not necessary if already included in default_groups
	-- leaving drop_name empty makes it drop itself
	can_duplicate[node_name] = true
	overrides[node_name] = overrides[node_name] or drop_name
end

function ancient_fertilizer.disallow_node(node_name)
	-- used to exclude individual nodes for balancing purposes
	-- like when it should be a rare resource
	disallowed[node_name] = true
end

function ancient_fertilizer.override_drop(node_name, drop_name)
	-- used when a node shouldn't drop itself
	-- like with cosmetic variations "default:grass_2", "default:grass_1"
	overrides[node_name] = drop_name
end

function ancient_fertilizer.has_variations(node_prefix, drop_name)
	-- so you don't have to override_drop every variation
	--                               "default:grass_", "default:grass_1"
	-- leaving drop_name empty makes each variation drop itself
	variations[node_prefix] = drop_name
end

function ancient_fertilizer.add_group(group_name)
	-- adds to default_groups for built-in support
	-- do not use the prefix "group:"
	default_groups[group_name] = true
end

-- INTERNALS

function ancient_fertilizer.should_affect(node_name)
	if state_cache[node_name] ~= nil then
		return state_cache[node_name]
	end

	if disallowed[node_name] then
		state_cache[node_name] = false
		return false
	end

	if can_duplicate[node_name] then
		state_cache[node_name] = true
		return true
	end

	for prefix, drop_name in pairs(variations) do
		if node_name:find("^" .. prefix) then
			state_cache[node_name] = true
			return true
		end
	end

	for group, _ in pairs(default_groups) do
		if minetest.get_item_group(node_name, group) > 0 then
			state_cache[node_name] = true
			return true
		end
	end

	state_cache[node_name] = false
	return false
end

function ancient_fertilizer.get_drop(node_name)
	local drop = drops_cache[node_name]
	if drop then
		return drop
	end

	drop = overrides[node_name]
	if drop then
		drops_cache[node_name] = drop
		return drop
	end

	for prefix, drop_name in pairs(variations) do
		if node_name:find("^" .. prefix) then
			drop = drop_name or node_name
			drops_cache[node_name] = drop
			return drop
		end
	end

	local basename = node_name:match("^(.+)_%d+$")
	if basename then
		drop = basename .. "_1"
		if minetest.registered_nodes[drop] then
			drops_cache[node_name] = drop
			return drop
		end
	end

	drops_cache[node_name] = node_name
	return node_name
end
