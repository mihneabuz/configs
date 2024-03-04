local M = {}

M.config = vim.diagnostic.config()

M.enabled = true

M.enable = function()
  vim.diagnostic.config(M.config)
end

M.disable = function()
  local settings = {}
  for _, setting in ipairs(vim.tbl_keys(M.config)) do
    settings[setting] = false
  end

  vim.diagnostic.config(settings)
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
