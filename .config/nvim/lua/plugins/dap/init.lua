return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "jay-babu/mason-nvim-dap.nvim" },
    keys = {
      { "<leader>DB", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>DD", function() require("dap").continue() end,          desc = "run debugger" },
    },
    opts = {
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
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

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
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "ErrorMsg", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "PmenuSel", linehl = "PmenuSel", numhl = "PmenuSel" })
    end
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "lldb", "delve", "python" },
      automatic_installation = true,
      handlers = {}
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = { "vim-test/vim-test" },
    keys = {
      { "<leader>z",  function() require("neotest").run.run() end },
      { "<leader>aa", function() require("neotest").run.run(vim.fn.expand("%")) end },
      { "<leader>ad", function() require("neotest").run.run({ strategy = "dap" }) end },
      { "<leader>al", function() require("neotest").output.open() end },
      { "<leader>as", function() require("neotest").summary.toggle() end },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          }),
          require("neotest-vim-test")({
            ignore_file_types = { "rust", "go" },
          }),
        }
      }
    end
  },

  { "rouge8/neotest-rust",           lazy = true },
  { "nvim-neotest/neotest-go",       lazy = true },
  { "nvim-neotest/neotest-vim-test", lazy = true },
  { "vim-test/vim-test",             lazy = true }
}
