local M = {}

M.setup = function(base_opts)
  local settings = {
    ["tsserver"] = {}
  }

  local opts = vim.tbl_deep_extend("force", { settings = settings }, base_opts)

  local success, typescript = pcall(require, "typescript")
  if not success then
    return false
  end

  typescript.setup({
    debug = false,
    go_to_source_definition = {
      fallback = true,
    },
    server = opts,
  })

  return true
end

return M
