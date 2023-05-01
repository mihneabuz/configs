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
    vim.api.nvim_create_augroup("DocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "DocumentHighlight",
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "DocumentHighlight",
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
  keymap("gr", "<cmd>Lspsaga lsp_finder<CR>")
  keymap("gpd", "<cmd>Lspsaga peek_definition<CR>")
  keymap("gpt", "<cmd>Lspsaga peek_type_definition<CR>")

  keymap("gic", "<cmd>Lspsaga incoming_calls<CR>")
  keymap("goc", "<cmd>Lspsaga outgoing_calls<CR>")

  keymap("gl", vim.diagnostic.open_float)
  keymap("[d", vim.diagnostic.goto_prev)
  keymap("]d", vim.diagnostic.goto_next)

  keymap("<leader>r", "<cmd>Lspsaga rename ++project<CR>")

  keymap("<leader>F", vim.lsp.buf.format)
  keymap("<leader>F", vim.lsp.buf.format, "v")

  keymap("<leader>ca", "<cmd>Lspsaga code_action<CR>")
  keymap("<leader>cl", function()
    vim.lsp.codelens.run()
    vim.lsp.codelens.refresh()
  end)

  keymap("<leader>o", "<cmd>Lspsaga outline<CR>")
end

M.base_opts = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
}

M.disable_formatter = function(opts)
  local old_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    old_on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end
end

M.manual = {
  ["rust_analyzer"] = true,
  ["tsserver"] = true,
}

M.automatic = {
  ["clangd"] = require("plugins.lsp.settings.clangd"),
  ["jsonls"] = require("plugins.lsp.settings.jsonls"),
  ["lua_ls"] = require("plugins.lsp.settings.lua"),
  ["emmet_ls"] = require("plugins.lsp.settings.emmet"),
}

M.setup = function(server)
  if M.manual[server] then
    return
  end

  local base = M.base_opts
  local extra = M.automatic[server] or {}

  local opts = vim.tbl_deep_extend("force", extra, base)

  require("lspconfig")[server].setup(opts)
end

return M
