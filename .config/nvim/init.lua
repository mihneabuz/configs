require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.bootstrap")

if vim.g["neovide"] ~= nil then
  require("config.neovide")
end
