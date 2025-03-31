local M = {};

M.kind_priority_table = {
  Keyword     = 20,

  Field       = 15,
  Variable    = 15,
  Property    = 15,
  Value       = 15,
  Reference   = 15,

  Constructor = 10,
  Method      = 10,
  Function    = 10,
  Operator    = 10,

  Constant    = 9,

  Class       = 8,
  Interface   = 8,
  Struct      = 8,
  Enum        = 8,
  EnumMember  = 8,

  Module      = 6,

  Snippet     = 5,

  Folder      = 3,
  File        = 2,
}

M.kind_priority_default = 7

M.kind_priority = function(kind)
  return M.kind_priority_table[kind] or M.kind_priority_default
end

M.compare_kind = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  if kind1 ~= kind2 then
    return M.kind_priority(kind1) > M.kind_priority(kind2)
  end
end

local kinds = require("themes").icons.kinds;
M.format = function(_, item)
  if kinds[item.kind] then
    item.kind = kinds[item.kind]
  else
    item.kind = "? "
  end

  item.abbr = string.sub(item.abbr, 1, 50)
  item.menu = nil

  return item
end

M.formatting = {
  fields = { "kind", "abbr" },
  format = M.format,
}

return M;
