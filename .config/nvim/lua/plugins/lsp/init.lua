return {

  -- installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" }
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
    opts = {
      diagnostics = {
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
    config = function(_, opts)
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      opts.diagnostics.signs = { active = signs }
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

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
      vim.api.nvim_set_hl(0, "Normal", { link = "NormalFloat" })
      require("lspsaga").setup(opts)
      vim.api.nvim_set_hl(0, "Normal", {})
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true
  },

  --  formatters, linters, code actions
  {
    "nvimtools/none-ls.nvim",
    branch = "0.7-compat",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")

      local sources = {
        -- trailling whitespace
        nls.builtins.diagnostics.trail_space,
        nls.builtins.formatting.trim_whitespace,

        -- git code actions
        nls.builtins.code_actions.gitsigns,
      }

      if vim.fn.executable("prettierd") == 1 then
        table.insert(sources, nls.builtins.formatting.prettierd)
      end

      if vim.fn.executable("eslint_d") == 1 then
        table.insert(sources, nls.builtins.diagnostics.eslint_d)
        table.insert(sources, nls.builtins.code_actions.eslint_d)
      end

      return {
        debug = false,
        on_attach = require("plugins.lsp.handlers").on_attach,
        sources = sources
      }
    end,
  },

  -- rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("plugins.lsp.handlers").setup_manual_server("rust_analyzer")
    end
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      null_ls = {
        enabled = true,
      },
    },
    config = function(_, opts)
      local crates = require("crates");
      crates.setup(opts)
      crates.show()
    end
  },

  -- typescript
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
    config = function()
      require("plugins.lsp.handlers").setup_manual_server("tsserver")
    end
  },
}
