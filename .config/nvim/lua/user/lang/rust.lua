local rust = {}

rust.setup = function(opts)
  local success, rt = pcall(require, "rust-tools")
  if success then
    local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

    local codelldb_path = mason_path .. "adapter/codelldb"
    local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

    local dap_adapter = {}
    if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
      dap_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    end

    rt.setup({
      tools = {
        runnables = { use_telescope = true },
        inlay_hints = { only_current_line = true },
      },
      server = opts,
      dap = { adapter = dap_adapter }
    })
  end
end

return rust
