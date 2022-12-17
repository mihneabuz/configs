local success, onedark = pcall(require, "onedark")
if not success then
	vim.notify("colorscheme onedark not found!")
	return
end

onedark.setup({
	transparent = true,
  colors = {
    fg = "#bac1ce"
  }
})

vim.cmd([[colo onedark]])
