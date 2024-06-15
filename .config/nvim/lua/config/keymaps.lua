local command = vim.api.nvim_create_user_command
local keymap = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- disable command line window
keymap("n", "q<cmd>", "<nop>")

-- close buffer
keymap("n", "<C-q>", "<cmd>bd<cr>")

-- window navigation
keymap("n", "<C-h>", "<C-w>h", "Navigate window left")
keymap("n", "<C-j>", "<C-w>j", "Navigate window down")
keymap("n", "<C-k>", "<C-w>k", "Navigate window up")
keymap("n", "<C-l>", "<C-w>l", "Navigate window right")

-- window resizing
keymap("n", "<S-Up>", "<cmd>resize -2<cr>", "Decrease window vertical size")
keymap("n", "<S-Down>", "<cmd>resize +2<cr>", "Increase window vertical size")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<cr>", "Decrease window horizontal size")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<cr>", "Increase window horizontal size")

-- splits
keymap("n", "<C-w>s", "<cmd>split<cr>", "Split window horizontal")
keymap("n", "<C-w>v", "<cmd>vsplit<cr>", "Split window vertical")

-- esc to leave terminal mode
keymap("t", "<Esc>", [[<C-\><C-n>]])

-- alt-s to leave insert/terminal mode
keymap("i", "<A-s>", [[<C-\><C-n>]])
keymap("t", "<A-s>", [[<C-\><C-n>]])

-- clear highlight
keymap("n", "<leader>h", "<cmd>noh<cr>", "Clear Highlight")

-- better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- better search
keymap("n", "*", "*N")

-- quickfix
keymap("n", "[q", "<cmd>try | cprev | catch | clast  | catch | endtry<cr>", "Next quickfix item")
keymap("n", "]q", "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>", "Prev quickfix item")

-- tab
keymap("n", "<leader><tab>", "<cmd>tabnew<cr>", "Create new tab")

-- Lazy
keymap("n", "<leader>L", "<cmd>Lazy<cr>", "Open Lazy")

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  keymap("n", "<leader>ui", vim.show_pos, "Show highlight under cursor")
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
keymap("n", "<leader>R", toggle_relative, "Toggle relative numbers")

-- toggle tab size
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
  if long then
    short_tab()
  else
    long_tab()
  end
end
command("TabLong", long_tab, { nargs = 0 })
command("TabShort", short_tab, { nargs = 0 })
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
command("Spellcheck", toggle_spellcheck, { nargs = 0 })
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
