local can_duplicate = {}
local disallowed = {}
local overrides = {}
local variations = {}

function ancient_fertilizer.add_node(node_name)
	-- nodes you want to be able to duplicate
	-- not necessary if already included in DEFAULT_GROUPS
	can_duplicate[node_name] = true
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

function ancient_fertilizer.get_drop(node_name)
	if overrides[node_name] then
		return overrides[node_name]
	end
	for prefix, drop_name in pairs(variations) do
		if node_name:find("^" .. prefix) then
			return drop_name or node_name
		end
	end
	return node_name
end

function ancient_fertilizer.should_affect(node_name)
	if disallowed[node_name] == true then
		return false
	end
	if can_duplicate[node_name] == true then
		return true
	end
	for group, _ in pairs(ancient_fertilizer.DEFAULT_GROUPS) do
		if minetest.get_item_group(node_name, group) > 0 then
			return true
		end
	end
	return false
end
