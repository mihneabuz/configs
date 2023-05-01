local M = {}

M.name = Colorscheme
if not M.name then
  M.name = "onedark"
end

M["onedark"] = require("themes.onedark")
M["tokyonight"] = require("themes.tokyonight")

M.default = M[M.name]

return M
