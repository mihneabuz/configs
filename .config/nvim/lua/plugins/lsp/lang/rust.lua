local M = {}

local function execute_command(command, args, cwd)
  require("toggleterm.terminal").Terminal
      :new({
        dir = cwd,
        cmd = require("rust-tools.utils.utils").make_command_from_args(command, args),
        close_on_exit = false,
      })
      :toggle()
end

M.setup = function(base_opts)
  local opts = base_opts

  local success, rt = pcall(require, "rust-tools")
  if not success then
    return false
  end

  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

  local codelldb_path = mason_path .. "adapter/codelldb"
  local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

  local dap_adapter = {}
  if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
    dap_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  end

  rt.setup({
    tools = {
      executor = { execute_command = execute_command },
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

  return true
end

return M
