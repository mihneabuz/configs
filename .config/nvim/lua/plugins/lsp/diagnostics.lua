local M = {}

M.init = function()
  M.opts = {
    underline = true,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.HINT]  = "",
        [vim.diagnostic.severity.INFO]  = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.ERROR] = "",
      },
      numhl = {
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      },
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

  M.enable()
end

M.enable = function()
  vim.diagnostic.config(vim.deepcopy(M.opts))
  M.enabled = true
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
  M.enabled = false
end

M.toggle = function()
  if M.enabled then
    M.disable()
  else
    M.enable()
  end
end

return M
