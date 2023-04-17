if not DebuggerInitialized then
  local success, dap = pcall(require, "dap")
  if not success then
    return
  end

  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'Substitute', linehl = 'Substitute', numhl = 'Substitute' })

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
