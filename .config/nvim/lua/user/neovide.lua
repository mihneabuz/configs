if not vim.g.neovide then
  return
end

local font_face = "CaskaydiaCove Nerd Font Mono"
local font_size = 16

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", font_face, font_size)
end

ResizeGuiFont = function(delta)
  font_size = font_size + delta
  RefreshGuiFont()
end

RefreshGuiFont()

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)

vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.85

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end
vim.g.neovide_background_color = "#202430" .. alpha()


vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0


vim.g.neovide_refresh_rate = 90
vim.g.neovide_refresh_rate_idle = 5
