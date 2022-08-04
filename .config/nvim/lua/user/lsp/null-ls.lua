local success, null_ls = pcall(require, "null-ls")
if not success then
	return
end

local actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		-- trailling whitespace
		diagnostics.trail_space,
		formatting.trim_whitespace,

		-- git code actions
		actions.gitsigns
	},
})
