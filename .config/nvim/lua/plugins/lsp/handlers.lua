---@diagnostic disable: undefined-global

local M = {}

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

  local preview_opts = {
    border = "rounded",
    max_width = 82,
  }

  keymap("K", function() vim.lsp.buf.hover(preview_opts) end, "Hover doc")

  keymap("gl", vim.diagnostic.open_float, "Show line diagnostics")
  keymap("gd", vim.lsp.buf.definition, "Go to definition")
  keymap("gh", vim.lsp.buf.type_definition, "Go to type definition")
  keymap("gr", Snacks.picker.lsp_references, "Show references")

  keymap("grr", function() vim.lsp.buf.references(nil, list_opts) end, "List references")
  keymap("gri", function() vim.lsp.buf.implementation(list_opts) end, "List implementations")
  keymap("gO", function() vim.lsp.buf.document_symbol(list_opts) end, "List document symbols")

  keymap("grn", vim.lsp.buf.rename, "Rename symbol")
  keymap("<leader>r", vim.lsp.buf.rename, "Rename symbol")

  keymap("<leader>ca", function() require("fastaction").code_action() end, "Code actions", { 'n', 'x' })

  keymap("<leader>dt", function() require("plugins.lsp.diagnostics").toggle() end, "Toggle diagnostics")

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

  if client:supports_method("textDocument/hover") then
    require("lsp_signature").on_attach({
      doc_lines    = 0,
      hint_enable  = false,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end

  -- if client:supports_method("textDocument/completion") then
  --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  -- end

  -- if client:supports_method("textDocument/inlayHint") then
  --   vim.lsp.inlay_hint.enable(true, { bufnr })
  -- end

  -- if client:supports_method("textDocument/codeLens") then
  --   vim.lsp.codelens.refresh()
  --
  --   vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  --     buffer = bufnr,
  --     callback = vim.lsp.codelens.refresh,
  --   })
  --
  --   keymap("grl", vim.lsp.codelens.run, "Code lens", { "n", "v" })
  -- end
end

M.base_opts = {
  on_attach = M.on_attach
}

M.automatic = {
  ["clangd"]        = function() return require("plugins.lsp.settings.clangd") end,
  ["jsonls"]        = function() return require("plugins.lsp.settings.jsonls") end,
  ["lua_ls"]        = function() return require("plugins.lsp.settings.lua") end,
  ["emmet_ls"]      = function() return require("plugins.lsp.settings.emmet") end,
  ["pylsp"]         = function() return require("plugins.lsp.settings.pylsp") end,
  ["rust_analyzer"] = function() return require("plugins.lsp.settings.rust_analyzer") end
}

M.extra_opts = function(server)
  local extra = M.automatic[server]
  if extra then
    return extra()
  end

  return {}
end

M.setup = function(server)
  local opts = vim.tbl_deep_extend("force", M.extra_opts(server), M.base_opts)
  require("lspconfig")[server].setup(opts)
end

return M
