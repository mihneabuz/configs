require("config.options")
require("config.bootstrap")
require("config.keymaps")
require("config.autocmds")

---@diagnostic disable: undefined-field
if vim.g.neovide then
  require("config.neovide")
end
