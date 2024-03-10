local overrides = {}
local disallowed = {}

function ancient_fertilizer.override_drop(node_name, drop_name)
	overrides[node_name] = drop_name
end

function ancient_fertilizer.get_drop(node_name)
	return overrides[node_name]
end

function ancient_fertilizer.disallow_node(node_name)
	disallowed[node_name] = true
end

function ancient_fertilizer.is_disallowed(node_name)
	return disallowed[node_name] == true
end


