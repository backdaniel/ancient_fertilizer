local default_groups = {can_duplicate = true}
local overrides = {}
local disallowed = {}

-- to add support for custom nodes simply add them to "group:can_duplicate"

function ancient_fertilizer.set_default_groups(group_list)
	-- this should be set per game
	-- groups that have some kind of "spreading" abm or known renewable vegetation
    default_groups = {can_duplicate = true}
    for _, group in ipairs(group_list) do
        default_groups[group] = true
    end
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

function ancient_fertilizer.is_disallowed(node_name)
	return disallowed[node_name] == true
end

function ancient_fertilizer.should_affect(node_name)
    for group, _ in pairs(default_groups) do
        if minetest.get_item_group(node_name, group) > 0 then
            return true and not ancient_fertilizer.is_disallowed(node_name)
        end
    end
    return false
end
