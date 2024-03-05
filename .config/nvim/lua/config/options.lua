vim.g["mapleader"] = " "

local opt = vim.opt

opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.smartcase = true
opt.hlsearch = true
opt.ignorecase = true
opt.cmdheight = 1
opt.termguicolors = true
opt.updatetime = 300
opt.number = true
opt.numberwidth = 3
opt.signcolumn = "yes"
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.foldmethod = "expr"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "0"
opt.pumheight = 10
opt.undofile = true
opt.relativenumber = true
opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = false
opt.formatoptions = "jcrqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"
opt.laststatus = 0
opt.list = true
opt.listchars = { tab = "· ", nbsp = "" }
opt.mouse = "a"
opt.pumblend = 0
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.shell = "/bin/bash"

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.cmd([[
  let g:loaded_python_provider=0
  let g:loaded_python3_provider=0
  let g:loaded_ruby_provider=0
  let g:loaded_node_provider=0
  let g:loaded_perl_provider=0
]])
