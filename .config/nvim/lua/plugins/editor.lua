return {

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>q", function() require("mini.bufremove").delete(0, false) end, desc = "close buffer" },
    },
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function() require("neo-tree.command").execute({ toggle = true }) end,
        desc = "Neo-tree",
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
      { "gG",         "<cmd>Telescope grep_string<cr>", desc = "grep word" },
      { "<leader>tt", "<cmd>Telescope<cr>",             desc = "Telescope" },
      { "<leader>tf", "<cmd>Telescope find_files<cr>",  desc = "find files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>",   desc = "live grep" },
      { "<leader>tr", "<cmd>Telescope oldfiles<cr>",    desc = "recent files" },
      { "<leader>tc", "<cmd>Telescope commands<cr>",    desc = "commands" },
      {
        "<leader>ts",
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
        desc = "symbols",
      },
      {
        "<leader>tG",
        function()
          require("telescope.builtin").grep_string({
            search = vim.fn.expand("<cword>")
          })
        end,
        desc = "grep under cursor",
      }
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-l>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-h>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("projects")
    end
  },

  -- quickfix list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      preview = {
        winblend = 0
      }
    }
  },

  -- project root
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    main = "project_nvim",
    config = true
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
      { "]t", function() require("todo-comments").jump_next() end, desc = "next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "previous todo" },
    },
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    keys = {
      { "<leader>sr", function() require("persistence").load() end,                desc = "restore session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "restore last session" },
    },
  },

  -- marking and navigation
  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>m", function() require("grapple").toggle() end,         desc = "toogle mark" },
      { "<leader>n", function() require("grapple").popup_tags() end,     desc = "marks menu" },
      { "<leader>N", function() require("grapple").quickfix() end,       desc = "marks quickfix" },
      { "[n",        function() require("grapple").cycle_forward() end,  desc = "prev mark" },
      { "]n",        function() require("grapple").cycle_backward() end, desc = "next mark" },
    },
    config = true,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    config = true
  },

  -- highlight ranges
  {
    "winston0410/range-highlight.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- motion
  {
    "phaazon/hop.nvim",
    keys = {
      { "<leader>f", "<cmd>HopWord<cr>", desc = "hop" }
    },
    config = true
  },

  -- escape insert with jk
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    main = "better_escape",
    config = true,
  },

  -- rgb colors
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cc", "<cmd>ColorizerToggle<cr>", desc = "toggle colorizer" },
    },
    config = function()
      require("colorizer").setup()
      vim.cmd.ColorizerToggle()
    end,
  },

  -- makes some plugins dot-repeatable
  { "tpope/vim-repeat",           event = "VeryLazy" },

  -- kitty term integration
  { "knubie/vim-kitty-navigator", event = "VeryLazy" }
}
