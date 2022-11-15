local success_lsp, lspconfig = pcall(require, "lspconfig")
if not success_lsp then
  return
end

local success_mason, mason = pcall(require, "mason")
if not success_mason then
  return
end

mason.setup()
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

local success_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not success_mason_lsp then
  return
end

mason_lsp.setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "gopls", "tsserver", "pyright" },
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

    if server_name == "sumneko_lua" then
      local sumneko_opts = require("user.lsp.settings.sumneko")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server_name == "rust_analyzer" then
      local success, rt = pcall(require, "rust-tools")
      if success then
        local codelldb_path = mason_path .. "adapter/codelldb"
        local liblldb_path = mason_path .. "lldb/lib/liblldb.so"
        local dap_adapter = false
        if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
          dap_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
        end
        return rt.setup({
          tools = {
            runnables = { use_telescope = true },
            inlay_hints = { only_current_line = true },
          },
          server = opts,
          dap = { adapter = dap_adapter }
        })
      end
    end

    lspconfig[server_name].setup(opts)
  end,
})

require("user.lsp.null-ls")
require("user.lsp.handlers").setup()
require("user.lsp.misc")
