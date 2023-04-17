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

local function pad(str, len)
  return str..string.rep(' ', len - string.len(str))
end

lualine.setup({
	options = {
    icons_enabled = true,
    theme = LualineTheme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', fmt = function(s) return pad(s, 7) end } },
    lualine_b = { diagnostics, 'branch', 'diff' },
    lualine_c = { 'filename'},
    lualine_x = { time, 'encoding', 'filesize', 'filetype' },
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
  winbar = {},
  inactive_winbar = {},
  extensions = {
		"nvim-tree",
    "nvim-dap-ui"
	}
})
