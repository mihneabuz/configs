return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function() require("neo-tree.command").execute({ toggle = true }) end,
        desc = "File explorer",
      },
    },
    opts = {
      add_blank_line_at_top = true,
      close_if_last_window = true,
      popup_border_style = "rounded",
      use_popups_for_input = false,
      enable_modified_markers = false,
      enable_opened_markers = false,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 48,
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node"
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = { "ahmedkhalf/project.nvim" },
    keys = {
      { "gG",     "<cmd>Telescope grep_string<cr>",     desc = "Search word under cursor" },
      { "<C-s>t", "<cmd>Telescope<cr>",                 desc = "Telescope" },
      { "<C-s>h", "<cmd>Telescope help_tags<cr>",       desc = "Help" },
      { "<C-s>f", "<cmd>Telescope find_files<cr>",      desc = "Files" },
      { "<C-s>g", "<cmd>Telescope live_grep<cr>",       desc = "Grep files" },
      { "<C-s>r", "<cmd>Telescope oldfiles<cr>",        desc = "Recent files" },
      { "<C-s>c", "<cmd>Telescope commands<cr>",        desc = "Commands" },
      { "<C-s>o", "<cmd>Telescope keymaps<cr>",         desc = "Git commits" },
      { "<C-s>k", "<cmd>Telescope keymaps<cr>",         desc = "Keymaps" },
      { "<C-s>v", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<C-s>d", "<cmd>Telescope diagnostics<cr>",     desc = "Diagnostics" },
      {
        "<C-s>s",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Symbols",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      opts.defaults.mappings = {
        i = {
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-l>"] = require("telescope.actions").cycle_history_next,
          ["<C-h>"] = require("telescope.actions").cycle_history_prev,
          ["<C-.>"] = require("telescope.actions").preview_scrolling_down,
          ["<C-,>"] = require("telescope.actions").preview_scrolling_up,
          ["<C-a>"] = function(...)
            require("telescope.actions").send_to_qflist(...)
            require("trouble").open("qflist")
          end,
          ["<C-s>"] = function(...)
            require("telescope.actions").send_selected_to_qflist(...)
            require("trouble").open("qflist")
          end,
        },
      }

      telescope.setup(opts)
      telescope.load_extension("projects")
    end
  },

  -- project root
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    main = "project_nvim",
    config = true
  },

  -- session management
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

  -- marking and navigation
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

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
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

  -- surround
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    config = true
  },

  -- highlight ranges
  {
    "winston0410/range-highlight.nvim",
    event = { "CmdlineEnter" },
    config = true,
  },

  -- motion
  {
    "smoka7/hop.nvim",
    keys = {
      { "<leader>f", "<cmd>HopWord<cr>", desc = "Hop" }
    },
    config = true
  },

  -- rgb colors
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

  -- makes some plugins dot-repeatable
  { "tpope/vim-repeat", event = "VeryLazy" },

}
