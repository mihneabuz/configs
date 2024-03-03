local M = {}

local root_fn = require("lspconfig").util.root_pattern("Cargo.toml")
local root_dir = root_fn(vim.fn.getcwd())

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
  local settings = {}

  if vim.fn.executable("leptosfmt") then
    local config = root_dir .. "/leptosfmt.toml"
    if vim.fn.filereadable(config) > 0 then
      settings["rust-analyzer"] = {
        rustfmt = {
          overrideCommand = { "leptosfmt", "--config-file", config, "--stdin", "--rustfmt" }
        }
      }
    end
  end

  return {
    root_dir = root_fn,
    settings = settings
  }
end

local function setup_dap_adapter()
  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")

  local codelldb_path = mason_path .. "adapter/codelldb"
  local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

  if vim.fn.filereadable(codelldb_path) > 0 and vim.fn.filereadable(liblldb_path) > 0 then
    return require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  end

  return {}
end

local function setup_tailwind_lsp(base_opts)
  if vim.fn.glob("tailwind.config.*") == "" then
    return
  end

  local opts = vim.tbl_extend("force", base_opts, {
    filetypes = { "rust" },
    init_options = {
      userLanguages = {
        rust = "javascript",
      },
    },
    settings = {
      tailwindCSS = {
        classAttribures = { "class" },
        validate = false,
      }
    }
  })

  require("lspconfig")["tailwindcss"].setup(opts)
end

M.setup = function(base_opts)
  local opts = vim.tbl_extend("force", base_opts, extra_opts())

  local success, rt = pcall(require, "rust-tools")
  if not success then
    return false
  end

  local dap_adapter = setup_dap_adapter()

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

  setup_tailwind_lsp(base_opts)

  return true
end

return M
