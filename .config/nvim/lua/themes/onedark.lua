return {
  opts = {
    transparent = true,
    colors = {
      fg = "#b2b9c6"
    },
    highlights = {
      ["MatchParen"] = { fg = "$yellow",  fmt = "bold" }
    }
  },

  lualine = function()
    local success, theme = pcall(require, "lualine.themes.onedark")
    if not success then
      return "auto"
    end

    local insert_bg = theme.insert.a.bg
    local normal_bg = theme.normal.a.bg
    theme.normal.a.bg = insert_bg
    theme.insert.a.bg = normal_bg

    return theme
  end,

  bufferline = function()
    return {
      fill = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      background = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "fg", highlight = "lualine_c_normal" },
      },

      duplicate = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        italic = true
      },
      modified = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },

      buffer_selected = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        bold = true
      },
      duplicate_selected = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        bold = true,
        italic = true
      },
      indicator_selected = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },
      modified_selected = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
      },

      buffer_visible = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      duplicate_visible = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        italic = true
      },
      indicator_visible = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      modified_visible = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
    }
  end
}