local success, onedark = pcall(require, "onedark")
if not success then
	vim.notify("colorscheme onedark not found!")
	return
end

onedark.setup({
	transparent = true
})

vim.cmd([[colo onedark]])
