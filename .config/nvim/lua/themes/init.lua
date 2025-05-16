local M = {}

M.name = os.getenv("COLORSCHEME")
if not M.name then
  M.name = "onedark"
end

---@diagnostic disable: different-requires
M["onedark"] = require("themes.onedark")
M["tokyonight"] = require("themes.tokyonight")

M.default = M[M.name]

M.icons = {
  diagnostics = {
    HINT  = "",
    INFO  = "",
    WARN  = "",
    ERROR = "",
  },
  kinds = {
    Array         = "[]",
    Boolean       = "󰔢 ",
    Class         = "󰠱 ",
    Color         = " ",
    Control       = " ",
    Collapsed     = " ",
    Constant      = " ",
    Constructor   = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = " ",
    Folder        = " ",
    Function      = "󰡱 ",
    Interface     = " ",
    Key           = " ",
    Keyword       = " ",
    Method        = " ",
    Module        = " ",
    Namespace     = " ",
    Null          = "󰟢 ",
    Number        = "󰎠 ",
    Object        = "{}",
    Operator      = "󰆕 ",
    Package       = " ",
    Property      = " ",
    Reference     = " ",
    Snippet       = " ",
    String        = " ",
    Struct        = " ",
    Text          = "󰉿 ",
    TypeParameter = " ",
    Unit          = " ",
    Value         = "󰎠 ",
    Variable      = "󰫧 ",
  }
}

return M
