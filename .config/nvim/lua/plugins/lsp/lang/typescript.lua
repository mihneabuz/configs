local M = {}

M.setup = function()
  local opts = require("plugins.lsp.handlers").base_opts

  local settings = {
    ["tsserver"] = {}
  }

  opts = vim.tbl_deep_extend("force", { settings = settings }, opts)

  if vim.fn.executable("prettierd") == 1 then
    require("plugins.lsp.handlers").disable_formatter(opts)
  end

  local success, typescript = pcall(require, "typescript")
  if not success then
    require("lspconfig")["tsserver"].setup(opts)
  end

  require("null-ls").register(require("typescript.extensions.null-ls.code-actions"))

  typescript.setup({
    debug = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = opts,
  })
end

return M
