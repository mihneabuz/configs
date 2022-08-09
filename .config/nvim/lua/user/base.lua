vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.formatoptions = "rnl"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.cmdheight = 1
vim.opt.termguicolors = true
vim.opt.timeoutlen = 600
vim.opt.updatetime = 300
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.pumheight = 12
vim.opt.undofile = true

vim.opt.shell = "/bin/bash"
vim.cmd([[set noshowmode]])
vim.cmd([[let g:loaded_perl_provider=0]])

vim.cmd([[
	:set foldtext=MyFoldText()
	function MyFoldText()
		let line = getline(v:foldstart)
		return line .. " "
	endfunction
]])
