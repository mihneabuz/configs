local keymap = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- splits
keymap("n", "<C-w><C-s>", "<cmd>split<cr>", "Split window horizontal")
keymap("n", "<C-w><C-v>", "<cmd>vsplit<cr>", "Split window vertical")

-- window resizing
keymap("n", "<S-Up>", "<cmd>resize -2<cr>", "Decrease window vertical size")
keymap("n", "<S-Down>", "<cmd>resize +2<cr>", "Increase window vertical size")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<cr>", "Decrease window horizontal size")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<cr>", "Increase window horizontal size")

-- alt-s to leave insert/terminal mode
keymap({ "i", "t" }, "<A-s>", [[<C-\><C-n>]])

-- clear highlight
keymap("n", "<leader>h", "<cmd>noh<cr>", "Clear Highlight")

-- better search
keymap("n", "*", "*N")

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Lazy
keymap("n", "<leader>L", "<cmd>Lazy<cr>", "Open Lazy")

local toggles = {}
local toggle = function(name, enable, disable)
  if toggles[name] then disable() else enable() end
  toggles[name] = not toggles[name]
end

-- toggle relative number
local toggle_relative = function()
  toggle(
    "relative",
    function() vim.opt.relativenumber = false end,
    function() vim.opt.relativenumber = true end
  )
end
keymap("n", "<leader>R", toggle_relative, "Toggle relative numbers")

-- toggle tab size
local function set_tab(n)
  vim.opt.tabstop = n
  vim.opt.shiftwidth = n
end
local function toggle_tab()
  toggle(
    "tab_len",
    function() set_tab(4) end,
    function() set_tab(2) end
  )
end
keymap("n", "<leader>T", toggle_tab, "Toggle tab width")

-- toggle spell check
local function toggle_spellcheck()
  toggle(
    "spell",
    function() vim.cmd([[setlocal spell spelllang=en_us]]) end,
    function() vim.cmd([[setlocal nospell]]) end
  )
end
keymap("n", "<leader>S", toggle_spellcheck, "Toggle spell check")

local wins = {}
local function toggle_win(name, opts)
  if wins[name] == nil then
    wins[name] = Snacks.win.new(opts)
  else
    wins[name]:toggle()
  end

  return wins[name]
end

local function toggle_term(name, exe, opts)
  local win = toggle_win(name, opts)

  if not win.closed then
    if vim.bo.buftype ~= "terminal" then
      vim.cmd.term(exe)
      vim.bo.buflisted = false
    end

    vim.cmd.startinsert()
  end
end

local function toggle_float_term()
  toggle_term("float_term", "fish", {
    border = "rounded"
  })
end

local function toggle_lazygit()
  toggle_term("lazygit_term", "lazygit")
end

keymap({ "n", "t" }, "<C-\\>", toggle_float_term, "Open floating terminal")
keymap({ "n", "t" }, "<C-'>", toggle_lazygit, "Open Lazygit")
