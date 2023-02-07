local packer_bootstrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

local success, packer = pcall(require, "packer")
if not success then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  }
})

return packer.startup(
  function(use)
    -- packer
    use "wbthomason/packer.nvim"

    -- impacient
    use "lewis6991/impatient.nvim"

    -- dependencies
    use "antoinemadec/FixCursorHold.nvim"
    use "winston0410/cmd-parser.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"

    -- mason
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "jayp0521/mason-nvim-dap.nvim"

    -- general
    use "kyazdani42/nvim-web-devicons"
    use "windwp/nvim-autopairs"
    use "norcalli/nvim-colorizer.lua"
    use "folke/todo-comments.nvim"
    use "winston0410/range-highlight.nvim"
    use "jghauser/fold-cycle.nvim"
    use "karb94/neoscroll.nvim"
    use "sudormrfbin/cheatsheet.nvim"
    use "dstein64/vim-startuptime"

    -- colorscheme
    use "navarasu/onedark.nvim"

    -- comments
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- treesitter
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-refactor"
    use {
      "nvim-treesitter/playground",
      opt = true,
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" }
    }

    -- completion
    use "hrsh7th/nvim-cmp" -- completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp" -- lsp completion
    use "hrsh7th/cmp-nvim-lua" -- nvim lua completion
    use "saadparwaiz1/cmp_luasnip" -- snippet completions

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- lsp
    use "neovim/nvim-lspconfig"
    use "jose-elias-alvarez/null-ls.nvim"
    use "kosayoda/nvim-lightbulb"
    use "ray-x/lsp_signature.nvim"
    use "onsails/lspkind.nvim"
    use {
      "weilbith/nvim-code-action-menu",
      opt = true,
      cmd = { "CodeActionMenu" },
      config = function()
        vim.g.code_action_menu_window_border = "rounded"
        vim.g.code_action_menu_show_details = false
      end
    }
    use {
      "folke/trouble.nvim",
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = function() require("trouble").setup() end
    }

    -- language specific
    use "simrat39/rust-tools.nvim"

    -- tests
    use {
      "klen/nvim-test",
      opt = false,
      cmd = { "TestNearest", "TestSuite", "TestFile" },
      config = function() require "user.tests" end
    }

    -- debugging
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"

    -- file tree
    use {
      "kyazdani42/nvim-tree.lua",
      tag = "nightly",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
      config = function() require "user.filetree" end
    }

    -- git
    use "lewis6991/gitsigns.nvim"

    -- buffers
    use "moll/vim-bbye"
    use {
      "akinsho/bufferline.nvim",
      tag = "v2.*"
    }

    -- statusline
    use "nvim-lualine/lualine.nvim"

    -- telescpope
    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      cmd = { "Telescope", "Cheatsheet" },
      config = function() require "user.telescope" end
    }

    -- terminal
    use {
      "akinsho/toggleterm.nvim",
      tag = "*",
      opt = true,
      cmd = { "ToggleTerm" },
      config = function() require "user.terminal" end
    }

    -- project
    use "ahmedkhalf/project.nvim"

    -- dashboard
    use "goolord/alpha-nvim"

    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
