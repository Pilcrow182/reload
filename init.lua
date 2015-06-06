if not reload then
	reload = {}
	reload.registered_items = {}
end

reload.register_item = function(name, def, type)
	type = type or "craftitem"

	if reload.registered_items[name] then
		print("DEBUG:: "..name.." has already been registered!")
		return
	end

	print("DEBUG:: registering "..name.." (type = "..type..")")
	minetest["register_"..type](name, def)
	reload.registered_items[name] = true
end

for _,type in ipairs({"node", "craftitem", "tool"}) do
	reload["register_"..type] = function(name, def)
		reload.register_item(name, def, type)
	end
end

reload.register_craftitem("reload:craftitem", {
	description = "test craftitem",
	inventory_image = "default_coal_lump.png",
})

-- register_item should be the same as register_craftitem
reload.register_item("reload:item", {
	description = "test item",
	inventory_image = "default_iron_lump.png",
})

reload.register_tool("reload:tool", {
	description = "test tool",
	inventory_image = "default_tool_steelpick.png",
})

reload.register_node("reload:node", {
	description = "test node",
	tiles = {"default_coal_block.png"},
	groups = {oddly_breakable_by_hand=1},
})

reload.register_node(":default:stone", {
	description = "test re-register",
	tiles = {"default_desert_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {cracky=3,flammable=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.after(1, function()
	dofile(minetest.get_modpath("reload").."/init.lua")
end)
