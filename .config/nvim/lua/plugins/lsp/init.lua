return {
  -- installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Open Mason" }
    },
    opts = {
      ui = {
        border = "rounded"
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "jsonls",
      },
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp.diagnostics").init()

      require("mason-lspconfig").setup_handlers({
        require("plugins.lsp.handlers").setup
      })

      vim.lsp.log.set_level("off")
    end,
  },

  -- lsp additions
  {
    "glepnir/lspsaga.nvim",
    keys = {
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code actions" }
    },
    opts = {
      lightbulb = {
        enable = false,
        enable_in_insert = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
      beacon = {
        enable = false
      },
      ui = {
        border = "rounded",
      }
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true
  },

  -- rust
  {
    "vxpm/ferris.nvim",
    ft = "rust",
    config = function()
      require("plugins.lsp.handlers").setup_manual_server("rust_analyzer")
    end
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function(_, opts)
      local crates = require("crates");
      crates.setup(opts)
      crates.show()
    end
  },
}
