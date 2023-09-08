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
    vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "LspDocumentHighlight",
      buffer = bufnr,
      callback = function()
        if vim.api.nvim_buf_line_count(0) < 10000 then
          vim.lsp.buf.document_highlight()
        end
      end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "LspDocumentHighlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  local keymap = function(bind, cmd, mode)
    mode = mode or "n"
    vim.keymap.set(mode, bind, cmd, { noremap = true, silent = true, buffer = bufnr })
  end

  keymap("K", vim.lsp.buf.hover)
  keymap("gk", vim.lsp.buf.signature_help)
  keymap("gd", vim.lsp.buf.definition)
  keymap("gD", vim.lsp.buf.declaration)
  keymap("gr", vim.lsp.buf.references)

  keymap("gR", "<cmd>Lspsaga lsp_finder<cr>")
  keymap("gpd", "<cmd>Lspsaga peek_definition<cr>")
  keymap("gpt", "<cmd>Lspsaga peek_type_definition<cr>")

  keymap("gic", "<cmd>Lspsaga incoming_calls<cr>")
  keymap("goc", "<cmd>Lspsaga outgoing_calls<cr>")

  keymap("gl", vim.diagnostic.open_float)
  keymap("[d", vim.diagnostic.goto_prev)
  keymap("]d", vim.diagnostic.goto_next)

  keymap("<leader>r", "<cmd>Lspsaga rename ++project<cr>")

  keymap("<leader>F", vim.lsp.buf.format, { "n", "v" })

  keymap("<leader>ca", "<cmd>Lspsaga code_action<cr>", { "n", "v" })
  keymap("<leader>cl", function()
    vim.lsp.codelens.run()
    vim.lsp.codelens.refresh()
  end)

  keymap("<leader>o", "<cmd>Lspsaga outline<cr>")

  keymap("<leader>" .. "-", "<cmd>LspStop<cr>")
  keymap("<leader>" .. "=", "<cmd>LspStart<cr>")
end

M.base_opts = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
}

M.disable_capability = function(opts, capability)
  local old_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    client.server_capabilities[capability] = false
    old_on_attach(client, bufnr)
  end
end

M.manual = {
  ["rust_analyzer"] = function() return require("plugins.lsp.lang.rust") end,
  ["tsserver"]      = function() return require("plugins.lsp.lang.typescript") end,
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
  local base_opts = require("plugins.lsp.handlers").base_opts

  local success = M.manual[server_name]().setup(base_opts)
  if not success then
    require("lspconfig")[server_name].setup(base_opts)
  end

  require("lspconfig.configs")[server_name].launch()
end

return M
