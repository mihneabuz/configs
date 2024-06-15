local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

M.on_attach = function(client, bufnr)
  if client.server_capabilities.hoverProvider then
    require("lsp_signature").on_attach({
      bind         = true,
      doc_lines    = 0,
      hint_enable  = false,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end

  if client.server_capabilities.documentHighlightProvider then
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

  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(bufnr, true)
  -- end

  -- if client.server_capabilities.codeLensProvider then
  --   vim.lsp.codelens.refresh()
  --   vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  --     buffer = bufnr,
  --     callback = vim.lsp.codelens.refresh,
  --   })
  -- end

  local keymap = function(bind, cmd, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, bind, cmd, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end

  keymap("K", vim.lsp.buf.hover, "Peek hover doc")
  keymap("<C-k>", "<cmd>Lspsaga hover_doc ++keep<cr>", "Toggle hover doc")

  keymap("gd", vim.lsp.buf.definition, "Go to definition")
  keymap("gh", vim.lsp.buf.type_definition, "Go to type definition")
  keymap("gr", vim.lsp.buf.references, "List references")
  keymap("gi", vim.lsp.buf.implementation, "List implementations")

  keymap("gD", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
  keymap("gH", "<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition")

  keymap("gI", vim.lsp.buf.incoming_calls, "List incoming calls")
  keymap("gO", vim.lsp.buf.outgoing_calls, "List outgoing calls")

  keymap("gl", vim.diagnostic.open_float, "Line diagnostics")
  keymap("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Next diagnostic")
  keymap("]d", function() vim.diagnostic.jump({ count =  1 }) end, "Prev diagnostic")

  keymap("<leader>r", vim.lsp.buf.rename, "Rename symbol")

  keymap("<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code actions", { "n", "v" })
  keymap("<leader>cl", function() vim.lsp.codelens.run() end, "Code lens")

  keymap("<leader>dt", function() require("plugins.lsp.diagnostics").toggle() end, "Toggle diagnostics")
end

M.base_opts = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
}

M.manual = {
  ["rust_analyzer"] = function() return require("plugins.lsp.lang.rust") end,
}

M.automatic = {
  ["clangd"]   = function() return require("plugins.lsp.settings.clangd") end,
  ["jsonls"]   = function() return require("plugins.lsp.settings.jsonls") end,
  ["lua_ls"]   = function() return require("plugins.lsp.settings.lua") end,
  ["emmet_ls"] = function() return require("plugins.lsp.settings.emmet") end,
  ["pylsp"]    = function() return require("plugins.lsp.settings.pylsp") end,
}

M.extra_opts = function(server)
  local extra = M.automatic[server]
  if extra then
    return extra()
  end

  return {}
end

M.setup = function(server)
  if M.manual[server] then
    return
  end

  local opts = vim.tbl_deep_extend("force", M.extra_opts(server), M.base_opts)

  require("lspconfig")[server].setup(opts)
end

M.setup_manual_server = function(server_name)
  if not pcall(require, "lspconfig") then
    return
  end

  local base_opts = require("plugins.lsp.handlers").base_opts

  local success = M.manual[server_name]().setup(base_opts)
  if not success then
    require("lspconfig")[server_name].setup(base_opts)
    require("lspconfig.configs")[server_name].launch()
  end
end

return M
