---@diagnostic disable: different-requires

return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local themes = require("themes")
      local onedark = require("onedark")
      onedark.setup(themes["onedark"].opts)

      if (themes.name == "onedark") then
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
      require("tokyonight").setup(themes["tokyonight"].opts)

      if (themes.name == "tokyonight") then
        vim.cmd([[colorscheme tokyonight]])
      end
    end
  }
}
