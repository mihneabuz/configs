return {
  { "folke/lazy.nvim" },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<C-s>", "g", "z" },
    opts = {
      icons = {
        mappings = false
      },
      spec = {
        { "<C-s>",     group = "Search" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>D", group = "Debugger" },
      },
    },
    config = function(_, opts)
      local whichkey = require("which-key")
      whichkey.setup(opts)

      local ignore_list = {
        "ge", "gg", "gi", "gn", "gN", "gv", "g~", "g%"
      }

      for _, ignored in ipairs(ignore_list) do
        whichkey.add({ { ignored, hidden = true } })
      end
    end
  },

  -- dependencies
  { "nvim-lua/plenary.nvim",       lazy = true },
  { "winston0410/cmd-parser.nvim", lazy = true },
}
