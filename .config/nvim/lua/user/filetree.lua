local success, nvim_tree = pcall(require, "nvim-tree")
if not success then
	return
end

local success_config, config = pcall(require, "nvim-tree.config")
if not success_config then
	return nvim_tree.setup()
end

local tree_cb = config.nvim_tree_callback

nvim_tree.setup({
	disable_netrw = true,
	view = {
		width = 42,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>" }, cb = tree_cb "edit" },
				{ key = "h", cb = tree_cb "close_node" },
				{ key = "v", cb = tree_cb "vsplit" },
				{ key = "s", cb = tree_cb "split" }
			}
		}
	}
})
