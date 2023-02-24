vim.cmd([[
  let g:mergetool_layout = 'mr'
  let g:mergetool_prefer_revision = 'local'
]])

local keymap = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

keymap("n", "<leader>mg", ":diffget<cr>", silent)
keymap("n", "<leader>mp", ":diffput<cr>", silent)
