local success, dap = pcall(require, "dap")
if not success then
  return
end

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'Substitute', linehl = 'Substitute', numhl = 'Substitute' })

local keymap = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

keymap("n", "<leader>DB", ":lua require'dap'.toggle_breakpoint()<CR>", silent)
keymap("n", "<leader>DD", ":lua require'dap'.continue()<CR>", silent)

local success, mason_dap = pcall(require, "mason-nvim-dap")
if success then
  mason_dap.setup({
    ensure_installed = { "lldb", "delve", "python" },
    automatic_setup = true,
  })

  mason_dap.setup_handlers({
    function(source_name)
      require("mason-nvim-dap.automatic_setup")(source_name)
    end,
  })
end

local success, dapui = pcall(require, "dapui")
if success then
  dapui.setup({
    icons = {
      expanded = "",
      collapsed = "",
      current_frame = ""
    },
    layouts = {
      {
        elements = {
          { id = "breakpoints", size = 0.20 },
          { id = "stacks", size = 0.20 },
          { id = "watches", size = 0.20 },
          { id = "scopes", size = 0.4 },
        },
        size = 60,
        position = "right",
      },
      {
        elements = {
          "repl",
        },
        size = 0.3,
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
      },
    }
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end
