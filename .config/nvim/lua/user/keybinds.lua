local command = vim.api.nvim_create_user_command
local keymap = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- swap ; and : in normal mode
keymap("n", ";", ":", { noremap = true })
keymap("n", ":", ";", { noremap = true })

-- window navigation
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)
keymap('t', '<C-h>', "<Cmd>wincmd h<CR>", silent)
keymap('t', '<C-j>', "<Cmd>wincmd j<CR>", silent)
keymap('t', '<C-k>', "<Cmd>wincmd k<CR>", silent)
keymap('t', '<C-l>', "<Cmd>wincmd l<CR>", silent)

-- window resizing
keymap("n", "<C-Up>", ":resize -2<CR>", silent)
keymap("n", "<C-Donw>", ":resize +2<CR>", silent)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", silent)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", silent)

-- cycle buffers
keymap("n", "<S-l>", ":bnext<CR>", silent)
keymap("n", "<S-h>", ":bprev<CR>", silent)

-- close buffer
keymap("n", "<leader>q", ":Bdelete<CR>", silent)
-- close window
keymap("n", "<leader>w", ":close<CR>", silent)

-- jk to leave insert mode and terminal mode
keymap("i", "jk", "<Esc>", silent)
keymap("t", "jk", [[<C-\><C-n>]], silent)

-- esc to leave terminal mode
keymap("t", "<Esc>", [[<C-\><C-n>]], silent)

-- clear highligh
keymap("n", "<leader>h", ":noh<CR>", silent)

-- better indent
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- move text
keymap("v", "<A-j>", ":m .+1<CR>==", silent)
keymap("v", "<A-k>", ":m .-1<CR>==", silent)
keymap("v", "p", '"_dP', silent)

keymap("x", "J", ":move '>+1<CR>gv-gv", silent)
keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", silent)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", silent)

-- toggle realtive number
local relative = false
local toggle_relative = function()
	if relative then
		vim.opt.number = true
		vim.opt.relativenumber = false
		relative = false
	else
		vim.opt.number = false
		vim.opt.relativenumber = true
		relative = true
	end
end
command("ToggleRelative", toggle_relative, { nargs = 0 })
keymap("n", "<leader>r", ":ToggleRelative<CR>", silent)

-- nvim tree
keymap("n", "<leader>o", ":NvimTreeToggle<CR>", silent)
keymap("n", "<leader>e", ":NvimTreeFocus<CR>", silent)

-- mason
keymap("n", "<leader>m", ":Mason<CR>", silent)

-- formatting
keymap("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", silent)

-- code actions
keymap("n", "<leader>ca", ":CodeActionMenu<CR>", silent)

-- testing
keymap("n", "<leader>A", ":TestSuite<CR>", silent)
keymap("n", "<leader>F", ":TestFile<CR>", silent)
keymap("n", "<leader>T", ":TestNearest<CR>", silent)

-- fold cycle
keymap("n", "zz", ":lua require('fold-cycle').toggle_all()<CR>", silent)

-- telescope
keymap("n", "<leader>tt", ":Telescope<CR>", silent)
keymap("n", "<leader>tf", ":Telescope find_files<CR>", silent)
keymap("n", "<leader>tg", ":Telescope live_grep<CR>", silent)
keymap("n", "<leader>tc", ":Telescope commands<CR>", silent)
keymap("n", "<leader>tv", ":Cheatsheet<CR>", silent)
keymap("n", "<leader>tp", ":Telescope projects<CR>", silent)

-- bufferline
keymap("n", "<leader>b", ":BufferLineSortByExtension<CR>", silent)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", silent)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", silent)

-- terminal
keymap("n", [[<C-\>]], "<Cmd>ToggleTerm direction=float<CR>", silent)
keymap("t", [[<C-\>]], "<Cmd>ToggleTerm direction=float<CR>", silent)
keymap("n", [[<C-]>]], "<Cmd>ToggleTerm size=16 direction=horizontal<CR>", silent)
keymap("t", [[<C-]>]], "<Cmd>ToggleTerm size=16 direction=horizontal<CR>", silent)
keymap("t", "ZZ", "<Cmd>:q<CR>", silent)

-- tab size
local function long_tab()
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
end
local function short_tab()
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
end
command("TabLong", long_tab, { nargs = 0 })
command("TabShort", short_tab, { nargs = 0 })

-- keybinds help
command("Keybinds", ":view ~/.config/nvim/keybinds", { nargs = 0 })
