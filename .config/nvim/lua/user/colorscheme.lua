local success, onedark = pcall(require, "onedark")
if not success then
	vim.notify("colorscheme onedark not found!")
	return
end

onedark.setup({
	transparent = true,
  colors = {
    fg = "#aeb5c2"
  }
})

vim.cmd([[colo onedark]])

LualineTheme = 'auto'
local success_theme, theme = pcall(require, "lualine.themes.onedark")
if success_theme then
	local insert_bg = theme.insert.a.bg
	local normal_bg = theme.normal.a.bg
	theme.normal.a.bg = insert_bg
	theme.insert.a.bg = normal_bg
	LualineTheme = theme
end

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
