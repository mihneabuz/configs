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

local function extra_opts()
  local root_dir = require("lspconfig").util.root_pattern("Cargo.toml")
  local settings = {}

  if vim.fn.executable("leptosfmt") then
    local config = root_dir(vim.fn.getcwd()) .. "/leptosfmt.toml"
    if vim.fn.filereadable(config) > 0 then
      settings["rust-analyzer"] = {
        rustfmt = {
          overrideCommand = { "leptosfmt", "--config-file", config, "--stdin", "--rustfmt" }
        }
      }
    end
  end

  return {
    root_dir = root_dir,
    settings = settings
  }
end

M.setup = function(base_opts)
  local opts = vim.tbl_extend("force", base_opts, extra_opts())

  local success, rt = pcall(require, "rust-tools")
  if not success then
    return false
  end

  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

  local codelldb_path = mason_path .. "adapter/codelldb"
  local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

  local dap_adapter = {}
  if vim.fn.filereadable(codelldb_path) > 0 and vim.fn.filereadable(liblldb_path) > 0 then
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
