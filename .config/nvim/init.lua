require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.bootstrap")

---@diagnostic disable: undefined-field
if vim.g.neovide then
  require("config.neovide")
end
