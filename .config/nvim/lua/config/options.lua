---@diagnostic disable: inject-field
vim.g.mapleader = " "
vim.g.deprecation_warnings = false
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = false
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.formatoptions = "jcrqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "· ", nbsp = "" }
opt.mouse = "a"
opt.number = true
opt.numberwidth = 3
opt.pumblend = 0
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shell = "/bin/bash"
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldmethod = "expr"
else
  opt.foldmethod = "indent"
end
