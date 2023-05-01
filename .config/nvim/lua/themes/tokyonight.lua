return {
  opts = {
    style = "night",
    light_style = "day",
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = {},
      functions = {},
      variables = {},
      sidebars = "transparent",
    },
    day_brightness = 0.3,
    dim_inactive = true,
    lualine_bold = false,
  },

  lualine = function()
    local success, theme = pcall(require, "lualine.themes.tokyonight")
    if not success then
      return "tokyonight"
    end

    theme.insert.a.bg = "#73daca"
    theme.insert.b.fg = "#73daca"

    return theme
  end,

  bufferline = function()
    return {
      buffer_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },
      duplicate_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },
      indicator_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },
      modified_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },
    }
  end,
}
