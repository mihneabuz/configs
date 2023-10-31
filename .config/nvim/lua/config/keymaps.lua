local command = vim.api.nvim_create_user_command
local keymap = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

-- window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- window resizing
keymap("n", "<S-Up>", "<cmd>resize -2<cr>")
keymap("n", "<S-Down>", "<cmd>resize +2<cr>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<cr>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<cr>")

-- splits
keymap("n", "cc", "<cmd>split<cr>")
keymap("n", "cv", "<cmd>vsplit<cr>")
keymap("n", "cx", "<cmd>q<cr>")

-- close window
keymap("n", "<leader>w", "<cmd>close<cr>")

-- close neovim
keymap("n", "<leader>Q", "<cmd>exit<cr>")

-- jk to leave terminal mode
keymap("t", "jk", [[<C-\><C-n>]])

-- esc to leave terminal mode
keymap("t", "<Esc>", [[<C-\><C-n>]])

-- clear highligh
keymap("n", "<leader>h", "<cmd>noh<cr>")

-- better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- better search
keymap("n", "*", "*N")

-- quickfix
keymap("n", "[q", "<cmd>try | cprev | catch | clast  | catch | endtry<cr>")
keymap("n", "]q", "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>")
keymap("n", "<C-q>", "<cmd>cclose<cr>")

-- tab
keymap("n", "<leader><tab>", "<cmd>tabnew<cr>")

-- Lazy
keymap("n", "<leader>L", "<cmd>Lazy<cr>")

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  keymap("n", "<leader>ui", vim.show_pos)
end

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
keymap("n", "<leader>R", toggle_relative)

-- tab size
local long = false
local function long_tab()
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  long = true
end
local function short_tab()
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  long = false
end
local function toggle_tab()
  if (long) then
    short_tab()
  else
    long_tab()
  end
end
command("TabLong", long_tab, { nargs = 0 })
command("TabShort", short_tab, { nargs = 0 })
keymap("n", "<leader>T", toggle_tab)

-- insert , or ; at the end of line
local function add_to_end(char)
  local pos = vim.api.nvim_win_get_cursor(0)
  local len = string.len(vim.api.nvim_call_function("getline", { pos[1] }))

  local lineEnd = { pos[1], len }
  vim.api.nvim_win_set_cursor(0, lineEnd)
  vim.api.nvim_put({ char }, "c", true, false)

  vim.api.nvim_win_set_cursor(0, pos)
end
keymap("n", "<leader>;", function() add_to_end(";") end)
keymap("n", "<leader>,", function() add_to_end(",") end)
