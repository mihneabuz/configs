return {
  { "folke/lazy.nvim" },

  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    config = function()
      require('which-key').setup()

      require('which-key').register {
        ['<C-s>'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      }
    end
  },

  -- dependencies
  { "nvim-lua/plenary.nvim",       lazy = true },
  { "winston0410/cmd-parser.nvim", lazy = true },
}
