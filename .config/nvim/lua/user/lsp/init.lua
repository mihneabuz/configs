local success_lsp, lspconfig = pcall(require, "lspconfig")
if not success_lsp then
  return
end

local function disable_formatter(opts)
  local old_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    old_on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end
end

local success_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if success_mason_lsp then
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
          disable_formatter(opts)
        end
      end

      if server_name == "clangd" then
        local clangd_opts = require("user.lsp.settings.clangd")
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
      end

      lspconfig[server_name].setup(opts)
    end,
  })
end

vim.lsp.set_log_level("off")

require("user.lsp.null-ls").setup()
require("user.lsp.handlers").setup()
require("user.lsp.misc")
