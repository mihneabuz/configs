local M = {}

M.init = function()
  M.opts = {
    underline = true,
    virtual_text = false,
    signs = {
      active = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }
    },
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
    update_in_insert = true,
    severity_sort = true,
  }

  for _, sign in ipairs(M.opts.signs.active) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  M.enable()

  M.enabled = true
end

M.enable = function()
  vim.diagnostic.config(vim.deepcopy(M.opts))
end

M.disable = function()
  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = false,
    underline = false,
    severity_sort = false,
    float = false,
    signs = false
  })
end

M.toggle = function()
  M.enabled = not M.enabled

  if M.enabled then
    M.enable()
  else
    M.disable()
  end
end

return M
