---@diagnostic disable: undefined-global

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<C-q>",     function() Snacks.bufdelete() end,        desc = "Close buffer" },
      { "<leader>e", function() Snacks.explorer() end,         desc = "File explorer" },

      { "<C-s>o",    function() Snacks.picker.pickers() end,   desc = "Pickers" },
      { "<C-s>f",    function() Snacks.picker.files() end,     desc = "Files" },
      { "<C-s>g",    function() Snacks.picker.grep() end,      desc = "Grep" },
      { "<C-s>r",    function() Snacks.picker.recent() end,    desc = "Recents" },
      { "<C-s>p",    function() Snacks.picker.projects() end,  desc = "Projects" },
      { "<C-s>l",    function() Snacks.picker.git_log() end,   desc = "Commits" },
      { "<C-s>h",    function() Snacks.picker.help() end,      desc = "Help" },
      { "<C-s>c",    function() Snacks.picker.commands() end,  desc = "Commands" },
      { "gG",        function() Snacks.picker.grep_word() end, desc = "Search word under cursor" },
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
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recents", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "s", desc = "Restore", action = ":lua require('persistence').load()" },
            { text = {} },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
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
        sources = {
          explorer = {

          }
        },
        icons = {
          diagnostics = require("themes").icons.diagnostics
        }
      },
      quickfile = { enabled = true },
      -- terminal = { enabled = true }
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = { "BufReadPost", "BufNewFile" },
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
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>dd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Buffer diagnostics"
      },
      {
        "<leader>dw",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Workspace diagnostics"
      },
    },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" }
    },
    keys = {
      { "<leader>s", function() require("persistence").load({ last = true }) end, desc = "Restore session" },
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
    config = true,
  },

  {
    "winston0410/range-highlight.nvim",
    event = { "CmdlineEnter" },
    config = true,
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

  {
    "akinsho/toggleterm.nvim",
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>",      desc = "Open terminal float", mode = { "n", "t" } },
      { [[<C-]>]], "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open terminal split", mode = { "n", "t" } },
    },
    cmd = "ToggleTerm",
    opts = {
      size = 20,
      hide_numbers = true,
      shading_factor = "2",
      direction = "float",
      shell = "fish -C fish_default_key_bindings",
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
      highlights = {
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
      },
    }
  },

}
