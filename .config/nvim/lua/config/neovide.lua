vim.o.guifont = "CaskaydiaCove_Nerd_Font:h13:w-0.2"

local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
local bg = require("themes").default.background
vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = fg })

vim.g.neovide_opacity = 0.95
vim.g.neovide_refresh_rate = 120
vim.g.neovide_refresh_rate_idle = 10
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_floating_blur = 0

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.fn.timer_start(40, function()
      vim.g.neovide_scroll_animation_length = 0.2
      vim.g.neovide_cursor_animation_length = 0.06
    end)
  end,
})
