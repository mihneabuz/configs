local M = {}

M.init = function()
  vim.diagnostic.config({
    underline = function() return M.enabled end,
    virtual_text = false,
    virtual_lines = false,
    signs = function()
      return M.enabled and {
        text = require("themes").icons.diagnostics
      }
    end,
    float = {
      border = "rounded",
      source = "always",
    },
    update_in_insert = false,
    severity_sort = true,
  })

  M.enable()
end

M.enable = function()
  M.enabled = true
  vim.diagnostic.show();
end

M.disable = function()
  M.enabled = false
  vim.diagnostic.hide();
end

M.toggle = function()
  if M.enabled then
    M.disable()
  else
    M.enable()
  end
end

return M
