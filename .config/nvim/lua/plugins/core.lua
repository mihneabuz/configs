return {
  { "folke/lazy.nvim" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        mappings = false
      },
      spec = {
        { "<C-s>",     group = "Search" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "gx",        desc = "Open URI under cursor" }
      },
    },
    config = function(_, opts)
      local whichkey = require("which-key")
      whichkey.setup(opts)

      local ignore_list = {
        "ge", "gg", "gn", "gN", "gv", "g%"
      }

      for _, ignored in ipairs(ignore_list) do
        whichkey.add({ { ignored, hidden = true } })
      end
    end
  },
}
