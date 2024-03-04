local M = {}

M.enabled = {}

M.register = function(bufnr)
  M.enabled[bufnr] = true

  vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = "LspDocumentHighlight",
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references
  })

  vim.api.nvim_create_autocmd("CursorHold", {
    group = "LspDocumentHighlight",
    buffer = bufnr,
    callback = function()
      if not M.enabled[bufnr] then
        local autocmds = vim.api.nvim_get_autocmds({ group = "LspDocumentHighlight", event = "CursorHold" })
        for _, autocmd in ipairs(autocmds) do
          ---@diagnostic disable: undefined-field
          if autocmd.buffer == bufnr then
            return vim.api.nvim_del_autocmd(autocmd.id)
          end
        end
      end

      if vim.api.nvim_buf_line_count(0) < 10000 then
        vim.lsp.buf.document_highlight()
      end
    end
  })
end

M.unregister = function(bufnr)
  M.enabled[bufnr] = nil
end

return M
