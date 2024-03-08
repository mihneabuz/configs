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
        border = "rounded",
        height = 0.8
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "clangd",
        "tsserver",
        "emmet_ls",
        "jsonls",
        "cssls",
        "tailwindcss",
        "pylsp"
      },
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.lsp.diagnostics").init()

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      require("mason-lspconfig").setup_handlers({
        require("plugins.lsp.handlers").setup
      })

      vim.lsp.set_log_level("off")
    end,
  },

  -- lsp additions
  {
    "glepnir/lspsaga.nvim",
    cmd = "Lspsaga",
    opts = {
      finder = {
        max_height = 0.5,
        min_width = 10,
        keys = {
          expand_or_jump = 'l',
        },
      },
      outline = {
        min_width = 16
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        virtual_text = false,
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
    config = function(_, opts)
      -- hack to set correct background
      local old = vim.api.nvim_get_hl_by_name("Normal", true)
      vim.api.nvim_set_hl(0, "Normal", { link = "NormalFloat" })
      require("lspsaga").setup(opts)
      vim.api.nvim_set_hl(0, "Normal", old)
    end
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
