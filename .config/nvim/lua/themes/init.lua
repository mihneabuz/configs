local M = {}

M.name = os.getenv("COLORSCHEME")
if not M.name then
  M.name = "onedark"
end

---@diagnostic disable: different-requires
M["onedark"] = require("themes.onedark")
M["tokyonight"] = require("themes.tokyonight")

M.default = M[M.name]

return M
