local success_onedark, onedark = pcall(require, "onedark")
if success_onedark then
  function ActivateOnedark()
    onedark.setup({
      transparent = true,
      colors = {
        fg = "#aeb5c2"
      }
    })

    local success_theme, theme = pcall(require, "lualine.themes.onedark")
    if success_theme then
      local insert_bg = theme.insert.a.bg
      local normal_bg = theme.normal.a.bg
      theme.normal.a.bg = insert_bg
      theme.insert.a.bg = normal_bg
      LualineTheme = theme
    end

    BufferlineTheme = {
      fill = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "bg", highlight = "lualine_c_normal " },
      },
      background = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "bg", highlight = "lualine_c_normal " },
      },
      buffer_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        fg = { attribute = "fg", highlight = "Function" },
        bold = true
      },
      duplicate_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        fg = { attribute = "fg", highlight = "Function" },
        bold = true,
        italic = true
      },
      indicator_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        fg = { attribute = "fg", highlight = "Function" },
      },
      buffer_visible = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      duplicate = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        italic = true
      },
      duplicate_visible = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        italic = true
      },
      indicator_visible = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "fg", highlight = "Type" },
      },
      modified = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "fg", highlight = "Type" },
      },
      modified_visible = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
        fg = { attribute = "fg", highlight = "Type" },
      },
      modified_selected = {
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        fg = { attribute = "fg", highlight = "Type" },
      },
      tab = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
      tab_selected = {
        fg = { attribute = "fg", highlight = "Function" },
        bg = { attribute = "bg", highlight = "lualine_b_normal" },
        bold = true
      },
      tab_close = {
        bg = { attribute = "bg", highlight = "lualine_c_normal" },
      },
    }

    vim.cmd([[colo onedark]])

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end
end


local success_tokyonight, tokyonight = pcall(require, "tokyonight")
if success_tokyonight then
  function ActivateTokyonight()
    tokyonight.setup({
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
    })

    local success_theme, theme = pcall(require, "lualine.themes.tokyonight")
    if success_theme then
      theme.insert.a.bg = "#73daca"
      theme.insert.b.fg = "#73daca"
      LualineTheme = theme
    end

    BufferlineTheme = {
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

    vim.cmd([[colo tokyonight]])
  end
end


LualineTheme = 'auto'
BufferlineTheme = {}

local color = os.getenv('COLORSCHEME')
if color == 'tokyonight' then
  pcall(ActivateTokyonight)
elseif color == 'onedark' then
  pcall(ActivateOnedark)
else
  pcall(ActivateOnedark)
end
