local keymap = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- window navigation
keymap("n", "<C-h>", "<C-w>h", "Navigate window left")
keymap("n", "<C-j>", "<C-w>j", "Navigate window down")
keymap("n", "<C-k>", "<C-w>k", "Navigate window up")
keymap("n", "<C-l>", "<C-w>l", "Navigate window right")

keymap("t", "<C-h>", "<C-w>h", "Navigate window left")
keymap("t", "<C-j>", "<C-w>j", "Navigate window down")
keymap("t", "<C-k>", "<C-w>k", "Navigate window up")
keymap("t", "<C-l>", "<C-w>l", "Navigate window right")

-- window resizing
keymap("n", "<S-Up>", "<cmd>resize -2<cr>", "Decrease window vertical size")
keymap("n", "<S-Down>", "<cmd>resize +2<cr>", "Increase window vertical size")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<cr>", "Decrease window horizontal size")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<cr>", "Increase window horizontal size")

-- splits
keymap("n", "<C-w>s", "<cmd>split<cr>", "Split window horizontal")
keymap("n", "<C-w>v", "<cmd>vsplit<cr>", "Split window vertical")

-- alt-s to leave insert/terminal mode
keymap("i", "<A-s>", [[<C-\><C-n>]])
keymap("t", "<A-s>", [[<C-\><C-n>]])

-- clear highlight
keymap("n", "<leader>h", "<cmd>noh<cr>", "Clear Highlight")

-- better search
keymap("n", "*", "*N")

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- highlights under cursor
keymap("n", "<leader>u", vim.show_pos, "Show highlight under cursor")

-- Lazy
keymap("n", "<leader>L", "<cmd>Lazy<cr>", "Open Lazy")

-- toggle relative number
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
keymap("n", "<leader>R", toggle_relative, "Toggle relative numbers")

-- toggle tab size
local long = false
local function set_tab(n)
  vim.print(n)
  vim.opt.tabstop = n
  vim.opt.shiftwidth = n
end
local function toggle_tab()
  if long then
    set_tab(2)
    long = false
  else
    set_tab(4)
    long = true
  end
end
keymap("n", "<leader>T", toggle_tab, "Toggle tab width")

-- toggle spell check
local spell = false
local function spellcheck()
  vim.cmd([[setlocal spell spelllang=en_us]])
  spell = true
end
local function nospellcheck()
  vim.cmd([[setlocal nospell]])
  spell = false
end
local function toggle_spellcheck()
  if spell then
    nospellcheck()
  else
    spellcheck()
  end
end
keymap("n", "<leader>S", toggle_spellcheck, "Toggle spell check")

-- insert , or ; at the end of line
local function add_to_end(char)
  local pos = vim.api.nvim_win_get_cursor(0)
  local len = string.len(vim.api.nvim_call_function("getline", { pos[1] }))

  local lineEnd = { pos[1], len }
  vim.api.nvim_win_set_cursor(0, lineEnd)
  vim.api.nvim_put({ char }, "c", true, false)

  vim.api.nvim_win_set_cursor(0, pos)
end
keymap("n", "<leader>;", function() add_to_end(";") end, "Add `;` to end of line")
keymap("n", "<leader>,", function() add_to_end(",") end, "Add `,` to end of line")
