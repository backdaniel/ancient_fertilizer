local can_duplicate = {}
local overrides = {}
local disallowed = {}

function ancient_fertilizer.add_node(node_name)
	-- nodes you want to be able to duplicate
	-- not necessary if already included in DEFAULT_GROUPS
	can_duplicate[node_name] = true
end

function ancient_fertilizer.override_drop(node_name, drop_name)
	-- used when a node shouldn't drop itself
	-- like with cosmetic variations "default:grass_2", "default:grass_1"
	overrides[node_name] = drop_name
end

function ancient_fertilizer.get_drop(node_name)
	return overrides[node_name] or node_name
end

function ancient_fertilizer.disallow_node(node_name)
	-- used to exclude individual nodes for balancing purposes
	-- like when it's not a renewable resource
	disallowed[node_name] = true
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
