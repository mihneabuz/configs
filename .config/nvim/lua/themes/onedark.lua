return {
  background = "#22272e",

  opts = {
    transparent = true,
    colors = {
      fg = "#b2b9c6",
    },
    highlights = {
      ["MatchParen"] = { fg = "$yellow", fmt = "bold" },
      ["NormalFloat"] = { bg = "$bg0" },
      ["FloatBorder"] = { bg = "$bg0" },
      ["Pmenu"] = { bg = "$bg0" },
      ["DiagnosticVirtualTextError"] = { bg = "clear" },
      ["DiagnosticVirtualTextWarn"] = { bg = "clear" },
      ["DiagnosticVirtualTextInfo"] = { bg = "clear" },
      ["DiagnosticVirtualTextHint"] = { bg = "clear" },
      ["@lsp.type.string.rust"] = { fg = "$green" },
      ["@lsp.typemod.string.macro.rust"] = { fg = "$green" },
      ["@lsp.type.generic.rust"] = { fg = "$yellow" },
      ["@lsp.type.operator.rust"] = { fg = "$fg" },
      ["@none.html"] = { fg = "$light_grey" },
      ["@spell.html"] = { fg = "$light_grey" },
      ["@lsp.type.selfKeyword.rust"] = { fg = "$red" },
      ["@lsp.typemod.selfKeyword.macro.rust"] = { fg = "$red" },
      ["@lsp.type.selfTypeKeyword.rust"] = { fg = "$yellow" },
      ["@lsp.typemod.selfTypeKeyword.macro.rust"] = { fg = "$yellow" }
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
