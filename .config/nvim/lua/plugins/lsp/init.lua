return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Open Mason" }
    },
    opts = {}
  },
  { "mason-org/mason-lspconfig.nvim", },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason-lspconfig").setup()
      require("plugins.lsp.handlers").init()
    end,
  },

  {
    'Chaitanyabsprip/fastaction.nvim',
    lazy = true,
    opts = {},
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
