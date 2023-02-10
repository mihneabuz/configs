local success, null_ls = pcall(require, "null-ls")
if not success then
	return
end

local actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local opts = {
	debug = false,
	sources = {
		-- trailling whitespace
		diagnostics.trail_space,
		formatting.trim_whitespace,

		-- git code actions
		actions.gitsigns,
	},
}

local has_prettierd = function()
  return vim.fn.executable('prettierd') == 1
end

if has_prettierd() then
  table.insert(opts.sources, null_ls.builtins.formatting.prettierd)
end

return {
  setup = function() null_ls.setup(opts) end,
  has_prettierd = has_prettierd
}
