return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<C-q>",     function() Snacks.bufdelete() end,       desc = "Close buffer" },
      { "<leader>q", function() Snacks.bufdelete.other() end, desc = "Close other buffers" },
      { "<leader>e", function() Snacks.explorer() end,        desc = "Open file explorer" },
      { "<leader>o", function() Snacks.picker.pickers() end,  desc = "Open pickers" },
      { "<leader>f", function() Snacks.picker.files() end,    desc = "Open file picker" },
      { "<leader>/", function() Snacks.picker.grep() end,     desc = "Search in workspace" },
      { "<leader>?", function() Snacks.picker.commands() end, desc = "Open command picker" },
    },
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        width = 40,
        preset = {
          keys = {
            { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files({ follow = true })" },
            { icon = " ", key = "r", desc = "Recents", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { text = {} },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { text = {} },
            { icon = " ", key = "h", desc = "Health", action = ":checkhealth" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        formats = {
          key = function(item)
            return { { "[" .. item.key .. "]", hl = "@function" } }
          end,
        },
        sections = {
          { section = "header", padding = 2 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { icon = " ", title = "Actions", section = "keys", indent = 2, padding = 2, gap = 0 },
          { section = "startup" },
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      input = { enabled = true },
      notify = { enabled = true },
      picker = {
        enabled = true,
        formatters = {
          file = {
            truncate = 72
          }
        },
        icons = {
          diagnostics = require("themes").icons.diagnostics
        },
      },
      quickfile = { enabled = true },
      terminal = { enabled = true },
      win = { enabled = true },
    },
  },

  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.move").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()
    end
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
    },
    opts = {
      keywords = {
        FIX  = { icon = " ", color = "#ff5135", alt = { "BUG", "ISSUE" } },
        TODO = { icon = " ", color = "#ffcc66", alt = { "DO" } },
        WARN = { icon = " ", color = "#ff8800", alt = { "WARNING" } },
        PERF = { icon = " ", color = "#c678dd", alt = { "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "#bbfdbb", alt = { "INFO" } },
        DEL  = { icon = " ", color = "#aabbdd", alt = { "DELETE", "TRASH", "TEMP" } }
      }
    },
  },

  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>N", function() require("grapple").toggle() end,         desc = "Toogle mark" },
      { "<leader>n", function() require("grapple").open_tags() end,      desc = "Show marks" },
      { "[n",        function() require("grapple").cycle_forward() end,  desc = "Prev mark" },
      { "]n",        function() require("grapple").cycle_backward() end, desc = "Next mark" },
    },
    opts = {},
  },

  {
    "winston0410/range-highlight.nvim",
    event = "CmdlineEnter",
    opts = {},
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>C", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer" },
    },
    config = function()
      require("colorizer").setup()
      vim.cmd.ColorizerToggle()
    end,
  },
}
