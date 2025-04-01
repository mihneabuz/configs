return {
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
    config = true
  },

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

  {
    "ray-x/lsp_signature.nvim",
    lazy = true
  },

  {
    'Chaitanyabsprip/fastaction.nvim',
    lazy = true,
    config = true,
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
