local M = {}

M.setup = function()
  local opts = require("plugins.lsp.handlers").base_opts

  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

  local codelldb_path = mason_path .. "adapter/codelldb"
  local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

  local dap_adapter = {}
  if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
    dap_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  end

  local settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true }
    }
  }

  opts = vim.tbl_deep_extend("force", { settings }, opts)

  local success, rt = pcall(require, "rust-tools")
  if not success then
    require("lspconfig")["rust_analyzer"].setup(opts)
  end

  rt.setup({
    tools = {
      runnables = {
        use_telescope = true
      },
      inlay_hints = {
        only_current_line = true
      },
    },
    server = opts,
    dap = {
      adapter = dap_adapter
    }
  })
end

return M
