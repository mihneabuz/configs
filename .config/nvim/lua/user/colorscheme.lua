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
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    })

    vim.cmd([[colo tokyonight]])
  end
end

LualineTheme = 'auto'

local color = os.getenv('COLORSCHEME')
if color then
  ActivateTokyonight()
else
  ActivateOnedark()
end
