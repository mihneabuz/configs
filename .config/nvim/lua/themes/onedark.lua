return {
  background = "#22272e",

  opts = {
    transparent = true,
    colors = {
      fg = "#b2b9c6",
    },
    highlights = {
      ["Special"] = { fg = "$blue", fmt = "bold" },
      ["MatchParen"] = { fg = "$yellow", fmt = "bold" },
      ["NormalFloat"] = { bg = "$bg0" },
      ["FloatBorder"] = { bg = "$bg0", fg = "$bg3" },
      ["Pmenu"] = { bg = "$bg0", fg = "$bg3" },
      ["DiagnosticVirtualTextError"] = { bg = "clear" },
      ["DiagnosticVirtualTextWarn"] = { bg = "clear" },
      ["DiagnosticVirtualTextInfo"] = { bg = "clear" },
      ["DiagnosticVirtualTextHint"] = { bg = "clear" },
      -- hacks
      ["SnacksDashboardHeader"] = { fg = "$cyan" },
      ["SnacksDashboardSpecial"] = { fg = "$yellow", fmt = "italic" },
      ["SnacksDashboardFooter"] = { fg = "$yellow", fmt = "italic" },
      ["BlinkCmpDocBorder"] = { bg = "$bg0", fg = "$bg3" },
      ["BlinkCmpDocSeparator"] = { bg = "$bg0", fg = "$bg3" },
      ["BlinkCmpDocCursorLine"] = { bg = "$bg0", fg = "$bg3" },
      ["BlinkCmpSignatureHelpBorder"] = { bg = "$bg0", fg = "$bg3" }
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
        fg = { attribute = "fg", highlight = "Normal" },
      },

      duplicate = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        italic = true
      },
      modified = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      pick = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        bold = true,
        italic = true,
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
      pick_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        bold = true,
        italic = true,
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
      pick_visible = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        bold = true,
        italic = true,
      },

      trunc_marker = {
        fg = { attribute = "fg", highlight = "lualine_c_normal" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      }
    }
  end
}
