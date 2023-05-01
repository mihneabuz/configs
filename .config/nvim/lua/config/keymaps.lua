local command = vim.api.nvim_create_user_command
local keymap = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

-- window navigation
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

keymap("t", "<C-h>", ":wincmd h<CR>", silent)
keymap("t", "<C-j>", ":wincmd j<CR>", silent)
keymap("t", "<C-k>", ":wincmd k<CR>", silent)
keymap("t", "<C-l>", ":wincmd l<CR>", silent)

-- window resizing
keymap("n", "<C-Up>", ":resize -2<CR>", silent)
keymap("n", "<C-Donw>", ":resize +2<CR>", silent)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", silent)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", silent)

-- splits
keymap("n", "cc", ":split<CR>", silent)
keymap("n", "cv", ":vsplit<CR>", silent)
keymap("n", "cx", ":q<CR>", silent)

-- cycle buffers
keymap("n", "<S-l>", ":bnext<CR>", silent)
keymap("n", "<S-h>", ":bprev<CR>", silent)

-- close window
keymap("n", "<leader>w", ":close<CR>", silent)

-- close neovim
keymap("n", "<leader>Q", ":exit<CR>", silent)

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

-- toggle realtive number
local relative = true
local toggle_relative = function()
  if relative then
    vim.opt.relativenumber = false
    relative = false
  else
    vim.opt.relativenumber = true
    relative = true
  end
end
command("ToggleRelative", toggle_relative, { nargs = 0 })
keymap("n", "<leader>R", ":ToggleRelative<CR>", silent)

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

-- stupid mac tilde
keymap("c", "±", "~", { noremap = true })
