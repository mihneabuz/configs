local success_line, lualine = pcall(require, "lualine")
if not success_line then
	return
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", "  " }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local time = function()
	return require("os").date("%H:%M")
end

local theme = 'auto'
local success_theme, onedark = pcall(require, "lualine.themes.onedark")
if success_theme then
	local insert_bg = onedark.insert.a.bg
	local normal_bg = onedark.normal.a.bg
	onedark.normal.a.bg = insert_bg
	onedark.insert.a.bg = normal_bg
	theme = onedark
end

lualine.setup({
	options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { diagnostics, 'branch', 'diff' },
    lualine_c = { 'filename'},
    lualine_x = { time, 'encoding', 'filetype'},
    lualine_y = { 'location' },
    lualine_z = { progress }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {
		"nvim-tree"
	}
})
