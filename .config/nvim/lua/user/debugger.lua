if not DebuggerInitialized then
  vim.notify('in debugger.lua')

  local success, dap = pcall(require, "dap")
  if not success then
    return
  end

  vim.notify('signs')

  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'Substitute', linehl = 'Substitute', numhl = 'Substitute' })

  local success_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
  if success_mason_dap then
    mason_dap.setup_handlers({
      function(source_name)
        require("mason-nvim-dap.automatic_setup")(source_name)
      end,
    })
  end

  local success_dapui, dapui = pcall(require, "dapui")
  if success_dapui then
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
            { id = "stacks",      size = 0.20 },
            { id = "watches",     size = 0.20 },
            { id = "scopes",      size = 0.4 },
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

  DebuggerInitialized = true
end
