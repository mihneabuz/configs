local M = {}

M.default_opts = {
  async = false,
  formatters = {},
  lsp_fallback = true,
}

M.opts_by_ft = {
  rust = vim.tbl_extend("force", M.default_opts, {
    lsp_fallback = "always",
  }),

  javascript = vim.tbl_extend("force", M.default_opts, {
    formatters = { { "prettierd", "prettier" } },
  }),
}

M.duplicated_ft = {
  typescript = "javascript",
  javascriptreact = "javascript",
  typescriptreact = "javascript",
}

M.get = function(filetype)
  return M.opts_by_ft[filetype] or M.default_opts
end

M.set = function(filetype, opts)
  M.opts_by_ft[filetype] = opts
end

M.add_formatter = function(filetype, formatter)
  local opts = M.get(filetype)
  table.insert(opts.formatters, formatter)
  M.set(opts)
end

M.format = function()
  local ft = M.duplicated_ft[vim.bo.filetype] or vim.bo.filetype
  local opts = M.opts_by_ft[ft] or M.default_opts
  require("conform").format(opts)
end

return M
