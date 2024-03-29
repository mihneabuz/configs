return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "jay-babu/mason-nvim-dap.nvim" },
    keys = {
      { "<leader>DB", function() require("plugins.dap.handlers").breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>DD", function() require("dap").continue() end,                    desc = "Start debugger" },
      { "<leader>DC", function() require("dapui").close() end,                     desc = "Close debugger" },
      { "<leader>DC", function() require("dapui").toggle() end,                    desc = "Toggle debugger" },
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
      require("plugins.dap.handlers").sign_setup()
    end
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "lldb" },
      automatic_installation = true,
      handlers = require("plugins.dap.handlers").setup
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>tz", function() require("neotest").run.run() end,                     desc = "Run test under cursor" },
      { "<leader>ta", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run all tests in file" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Run test with debugger" },
      { "<leader>tl", function() require("neotest").output.open() end,                 desc = "Open test ouput" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Show test summary" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }),
        }
      }
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
      require("plugins.dap.handlers").set_signcolumn()
    end
  },

  { "nvim-neotest/nvim-nio", lazy = true },
  { "rouge8/neotest-rust",   lazy = true },
}
