local Util = require("utils")

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
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      add_blank_line_at_top = true,
      close_if_last_window = true,
      popup_border_style = "rounded",
      use_popups_for_input = false,
      enable_modified_markers = false,
      enable_opened_markers = false,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node"
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
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
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      { "ahmedkhalf/project.nvim", main = "project_nvim", config = true },
    },
    keys = {
      { "<leader>tt", "<cmd>Telescope<cr>",           desc = "Telescope" },
      { "<leader>tf", Util.telescope("files"),        desc = "find files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { "<leader>tr", "<cmd>Telescope oldfiles<cr>",  desc = "recent files" },
      { "<leader>tc", "<cmd>Telescope commands<cr>",  desc = "commands" },
      {
        "<leader>ts",
        Util.telescope("lsp_dynamic_workspace_symbols", {
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
        }),
        desc = "symbols",
      },
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
            ["<a-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<a-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
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

      local project, _ = pcall(require, "project_nvim")
      if project then
        telescope.load_extension("projects")
      end

      telescope.setup(opts)
    end
  },

  -- which-key
  {
    "folke/which-key.nvim",
    lazy = true,
    -- event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode           = { "n", "v" },
        ["]"]          = { name = "+next" },
        ["["]          = { name = "+prev" },
        ["<leader>g"]  = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>d"]  = { name = "+diagnostics" },
        ["<leader>t"]  = { name = "+telescope" },
        ["<leader>s"]  = { name = "+session" }
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
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

  -- harpoon
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>m", function() require("harpoon.mark").add_file() end, desc = "mark file" },
      { "<leader>n", function() require("harpoon.ui").toggle_quick_menu() end, desc = "marks menu" },
      { "[n", function() require("harpoon.ui").nav_prev() end, desc = "prev mark" },
      { "]n", function() require("harpoon.ui").nav_prev() end, desc = "next mark" },
    }
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>S", function() require("spectre").open() end, desc = "Spectre" },
    },
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
      vim.cmd([[ColorizerToggle]])
    end,
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

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- kitty term integration
  { "knubie/vim-kitty-navigator", event = "VeryLazy" }
}
