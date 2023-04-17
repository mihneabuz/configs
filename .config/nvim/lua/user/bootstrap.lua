local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- dependencies
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "winston0410/cmd-parser.nvim",

  -- mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jayp0521/mason-nvim-dap.nvim",

  -- general
  "kyazdani42/nvim-web-devicons",
  "windwp/nvim-autopairs",
  "norcalli/nvim-colorizer.lua",
  "folke/todo-comments.nvim",
  "winston0410/range-highlight.nvim",
  "jghauser/fold-cycle.nvim",
  "karb94/neoscroll.nvim",
  "sudormrfbin/cheatsheet.nvim",
  "petertriho/nvim-scrollbar",
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },

  -- colorscheme
  "navarasu/onedark.nvim",
  "folke/tokyonight.nvim",

  -- comments
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-refactor",
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" }
  },

  -- completion
  "hrsh7th/nvim-cmp",           -- completion plugin
  "hrsh7th/cmp-buffer",         -- buffer completions
  "hrsh7th/cmp-path",           -- path completions
  "hrsh7th/cmp-cmdline",        -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",       -- lsp completion
  "hrsh7th/cmp-nvim-lua",       -- nvim lua completion
  "saadparwaiz1/cmp_luasnip",   -- snippet completions

  -- snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  -- lsp
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "kosayoda/nvim-lightbulb",
  "ray-x/lsp_signature.nvim",
  "onsails/lspkind.nvim",
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = function()
      vim.g.code_action_menu_window_border = "rounded"
      vim.g.code_action_menu_show_details = false
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function() require("trouble").setup() end
  },

  -- language specific
  "simrat39/rust-tools.nvim",
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function() require('crates').setup() end,
  },

  -- tests
  {
    "klen/nvim-test",
    cmd = { "TestNearest", "TestSuite", "TestFile" },
    config = function() require "user.tests" end
  },

  -- debugging
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",

  -- file tree
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    config = function() require "user.filetree" end
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require "user.git" end
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gvdiffsplit" }
  },
  {
    "samoshkin/vim-mergetool",
    cmd = { "MergetoolStart", "MergetoolStop", "MergetoolToggle" },
    config = function() require "user.mergetool" end
  },

  -- buffers
  "moll/vim-bbye",
  {
    "akinsho/bufferline.nvim",
    version = "v3.*"
  },

  -- statusline
  "nvim-lualine/lualine.nvim",

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope", "Cheatsheet" },
    config = function() require "user.telescope" end
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function() require "user.terminal" end
  },

  -- project
  "ahmedkhalf/project.nvim",

  -- dashboard
  "goolord/alpha-nvim",
})
