return {
  {
    "folke/lazy.nvim",
    version = "*",
    keys = {
      { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
    }
  },

  {
    "folke/which-key.nvim",
    cmd = { "WhichKey" },
    config = true
  },

  -- dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "winston0410/cmd-parser.nvim", lazy = true },
}
