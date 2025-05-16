local M = {}

M.init = function()
  vim.lsp.config("*", require('blink.cmp').get_lsp_capabilities())

  for server, config in pairs(M.automatic) do
    vim.lsp.config(server, config)
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      M.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end,
  })

  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    virtual_lines = false,
    signs = {
      text = require("themes").icons.diagnostics
    },
    float = {
      source = true,
    },
    update_in_insert = false,
    severity_sort = true,
  })

  vim.lsp.log.set_level("off")
end

M.automatic = {
  ["clangd"]        = require("plugins.lsp.settings.clangd"),
  ["emmet_ls"]      = require("plugins.lsp.settings.emmet"),
  ["jsonls"]        = require("plugins.lsp.settings.jsonls"),
  ["lua_ls"]        = require("plugins.lsp.settings.lua"),
  ["pylsp"]         = require("plugins.lsp.settings.pylsp"),
  ["rust_analyzer"] = require("plugins.lsp.settings.rust_analyzer"),
  ["tailwindcss"]   = require("plugins.lsp.settings.tailwindcss")
}

M.on_attach = function(client, bufnr)
  local keymap = function(bind, cmd, desc, mode)
    local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set(mode or "n", bind, cmd, opts)
  end

  local list_opts = {
    on_list = function(what)
      vim.fn.setqflist({}, ' ', what)
      require("trouble").open("qflist")
    end
  }

  keymap("K", function() vim.lsp.buf.hover({ max_width = 82 }) end, "Hover doc")

  keymap("gd", vim.lsp.buf.definition, "Go to definition")
  keymap("gh", vim.lsp.buf.type_definition, "Go to type definition")
  keymap("gr", Snacks.picker.lsp_references, "Show references")

  keymap("grr", function() vim.lsp.buf.references(nil, list_opts) end, "List references")
  keymap("gri", function() vim.lsp.buf.implementation(list_opts) end, "List implementations")
  keymap("gO", function() vim.lsp.buf.document_symbol(list_opts) end, "List document symbols")

  local toggle_diagnostics = function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end

  keymap("gl", vim.diagnostic.open_float, "Show line diagnostics")
  keymap("<leader>dt", toggle_diagnostics, "Toggle diagnostics")

  if client:supports_method("textDocument/rename") then
    keymap("grn", vim.lsp.buf.rename, "Rename symbol")
    keymap("<leader>r", vim.lsp.buf.rename, "Rename symbol")
  end

  if client:supports_method("textDocument/codeAction") then
    keymap("<leader>ca", function() require("fastaction").code_action() end, "Code actions", { 'n', 'x' })
  end

  if client:supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      buffer = bufnr,
      callback = function()
        if vim.api.nvim_buf_line_count(0) < 10000 then
          vim.lsp.buf.document_highlight()
        end
      end
    })

    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  if client:supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh()

    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })

    keymap("<leader>cl", vim.lsp.codelens.run, "Code lens", { "n", "v" })
  end

  if client:supports_method("textDocument/inlayHint") then
    local toggle_inlay_hint = function()
      if vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(false, { bufnr })
      else
        vim.lsp.inlay_hint.enable(true, { bufnr })
      end
    end

    keymap("<leader>ci", toggle_inlay_hint, "Toggle inlay hints")
  end
end

return M
