return {
  { "folke/lazy.nvim" },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<C-s>", "g", "z" },
    config = function()
      local whichkey = require("which-key")
      whichkey.setup()

      whichkey.register({
        ["<C-s>"]     = { name = "Search",      _ = "which_key_ignore" },
        ["<leader>g"] = { name = "Git",         _ = "which_key_ignore" },
        ["<leader>c"] = { name = "Code",        _ = "which_key_ignore" },
        ["<leader>t"] = { name = "Tests",       _ = "which_key_ignore" },
        ["<leader>d"] = { name = "Diagnostics", _ = "which_key_ignore" },
        ["<leader>D"] = { name = "Debugger",    _ = "which_key_ignore" },
      })

      local ignore_list = {
        "ge", "gg", "gi", "gn", "gN", "gv", "g~", "g%"
      }

      for _, ignored in ipairs(ignore_list) do
        whichkey.register({
          [ignored] = "which_key_ignore"
        })
      end
    end
  },

  -- dependencies
  { "nvim-lua/plenary.nvim",       lazy = true },
  { "winston0410/cmd-parser.nvim", lazy = true },
}
