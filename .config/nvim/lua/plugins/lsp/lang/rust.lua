local M = {}

local root_fn = require("lspconfig").util.root_pattern("Cargo.toml")
local root_dir = root_fn(vim.fn.getcwd())

local function should_use_leptosfmt()
  if root_dir ~= nil and vim.fn.executable("leptosfmt") then
    local config = root_dir .. "/leptosfmt.toml"
    if vim.fn.filereadable(config) > 0 then
      return true
    end
  end

  return false
end

local function override_leptosfmt()
  return {
    "leptosfmt", "--config-file", root_dir .. "/leptosfmt.toml", "--stdin", "--rustfmt"
  }
end

local function extra_opts()
  local settings = {
    ["rust_analyzer"] = {
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    }
  }

  if should_use_leptosfmt() then
    settings = vim.tbl_deep_extend("force", settings, {
      ["rust-analyzer"] = {
        rustfmt = { overrideCommand = override_leptosfmt() }
      }
    })
  end

  return {
    root_dir = root_fn,
    settings = settings,
  }
end

local function should_setup_tailwind()
  return vim.fn.glob("tailwind.config.*") ~= ""
end

local function setup_tailwind()
  require("plugins.format.handlers").add_formatter("rust", "rustywind")

  require("lspconfig")["tailwindcss"].setup({
    filetypes = { "rust" },
    init_options = {
      userLanguages = {
        rust = "javascript",
      },
    },
  })
end

local function setup_ferris()
  require("ferris").setup()

  local function ferris_keymap(mode, key, fn, desc)
    vim.keymap.set(mode, key, "", {
      callback = function() require("ferris.methods." .. fn)() end,
      desc = desc,
      silent = true,
    })
  end

  ferris_keymap("n", "<leader>w", "reload_workspace", "Reload cargo workspace")
  ferris_keymap("n", "gw", "open_documentation", "Go to documentation")
  ferris_keymap("n", "gm", "view_memory_layout", "Show memory layout")
end

M.setup = function(base_opts)
  setup_ferris()

  local opts = vim.tbl_extend("force", base_opts, extra_opts())
  require("lspconfig")["rust_analyzer"].setup(opts)

  if should_setup_tailwind() then
    setup_tailwind()
  end

  return true
end

return M
