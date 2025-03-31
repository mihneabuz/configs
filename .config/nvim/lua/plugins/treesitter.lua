return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "go",
        "haskell",
        "hcl",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "make",
        "python",
        "rust",
        "toml",
        "typescript",
        "tsx",
        "yaml",
        "markdown",
        "markdown_inline",
        "query",
        "regex"
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "function outer" },
            ["if"] = { query = "@function.inner", desc = "function inner" },

            ["ac"] = { query = "@class.outer", desc = "class outer" },
            ["ic"] = { query = "@class.inner", desc = "class inner" },
          },
        }
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    config = true
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    config = true
  }
}
