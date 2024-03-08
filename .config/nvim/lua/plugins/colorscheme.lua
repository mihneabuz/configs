---@diagnostic disable: different-requires

return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local themes = require("themes")

      if (themes.name == "onedark") then
        local onedark = require("onedark")
        onedark.setup(themes["onedark"].opts)
        onedark.load()
      end
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local themes = require("themes")

      if (themes.name == "tokyonight") then
        require("tokyonight").setup(themes["tokyonight"].opts)
        vim.cmd([[colorscheme tokyonight]])
      end
    end
  }
}
