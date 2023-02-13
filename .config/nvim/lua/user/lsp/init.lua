local success_lsp, lspconfig = pcall(require, "lspconfig")
if not success_lsp then
  return
end

local success_mason, mason = pcall(require, "mason")
if not success_mason then
  return
end

mason.setup()

local success_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not success_mason_lsp then
  return
end

mason_lsp.setup({
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "clangd",
    "pyright",
    "tsserver", "emmet_ls", "jsonls", "tailwindcss"
  },
  automatic_installation = true,
})

mason_lsp.setup_handlers({
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    if server_name == "jsonls" then
      local jsonls_opts = require("user.lsp.settings.jsonls")
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server_name == "lua_ls" then
      local sumneko_opts = require("user.lsp.settings.lua")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server_name == "rust_analyzer" then
      require("user.lang.rust").setup(opts)
    end

    if server_name == "emmet_ls" then
      require("user.lsp.settings.emmet")
    end

    if server_name == "tsserver" then
      if require('user.lsp.null-ls').has_prettierd() then
        local old = opts.on_attach
        opts.on_attach = function(client, bufnr)
          old(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end
      end
    end

    lspconfig[server_name].setup(opts)
  end,
})

require("user.lsp.null-ls").setup()
require("user.lsp.handlers").setup()
require("user.lsp.misc")
