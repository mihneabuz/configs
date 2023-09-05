return {

  -- notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>u",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "dismiss notifications",
      },
    },
    opts = {
      timeout = 1500,
      max_height = function()
        return math.floor(vim.o.lines * 0.4)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.6)
      end,
      background_colour = "NormalFloat",
      stages = "fade",
      render = "minimal",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = false,
    event = "VeryLazy",
    dependencies = { "lualine.nvim", },
    keys = {
      { "<S-l>",     "<cmd>keepjumps BufferLineCycleNext<cr>" },
      { "<S-h>",     "<cmd>keepjumps BufferLineCyclePrev<cr>" },
      { "<leader>B", "<cmd>keepjumps BufferLineSortByExtension<cr>", desc = "sort buffers" },
      { "<leader>b", "<cmd>keepjumps BufferLinePick<cr>",            desc = "pick buffer" },
    },
    opts = function()
      return {
        options = {
          numbers                 = "none",
          right_mouse_command     = nil,
          left_mouse_command      = nil,
          middle_mouse_command    = nil,
          indicator               = { icon = "▐" },
          modified_icon           = "",
          max_name_length         = 28,
          max_prefix_length       = 12,
          enforce_regular_tabs    = false,
          diagnostics             = false,
          offsets                 = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "BufferLineFill",
              text_align = "left",
            },
          },
          show_buffer_icons       = true,
          show_buffer_close_icons = false,
          show_close_icon         = false,
          show_tab_indicators     = false,
          persist_buffer_sort     = true,
          separator_style         = {},
          always_show_bufferline  = false,
          custom_areas            = {
            right = function()
              local res = {}
              local total = #vim.api.nvim_list_tabpages()

              if total > 1 then
                local tabpage = vim.api.nvim_get_current_tabpage()
                local fg = vim.api.nvim_get_hl_by_name("Keyword", true).foreground
                table.insert(res, {
                  text = "" .. tabpage .. "  " .. total .. " ",
                  fg = fg
                })
              end

              return res
            end,
          }
        },
        highlights = require("themes").default.bufferline,
      }
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local function pad(str, len)
        return str .. string.rep(" ", len - string.len(str))
      end

      local diagnostics = {
        "diagnostics",
        sources          = { "nvim_diagnostic" },
        sections         = { "error", "warn" },
        symbols          = { error = " ", warn = " " },
        colored          = false,
        update_in_insert = false,
        always_visible   = true,
      }

      local filetype = {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 1, right = 0 }
      }

      local filename = {
        "filename",
        symbols = {
          modified = "󰏫",
          readonly = "",
          unnamed = "",
          newfile = ""
        }
      }

      local mark = function()
        local marked = require("grapple").exists({ buffer = 0 })
        if marked then
          return ""
        end
        return ""
      end

      local lsp = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end

        local names = {}
        for i = #clients, 1, -1 do
          names[#names + 1] = clients[i].name
        end

        return string.format(" LSP [%s]", table.concat(names, ", "))
      end

      local time = function()
        return require("os").date(" %H:%M")
      end

      return {
        options = {
          theme                = require("themes").default.lualine,
          globalstatus         = true,
          always_divide_middle = true,
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          disabled_filetypes   = {
            statusline = { "dashboard", "alpha" }
          },
        },
        sections = {
          lualine_a = { { "mode", fmt = function(s) return pad(s, 7) end } },
          lualine_b = { diagnostics, "branch", "diff" },
          lualine_c = { filetype, filename, mark },
          lualine_x = { lsp },
          lualine_y = { "location" },
          lualine_z = { time },
        },
        extensions = {
          "neo-tree",
          "lazy",
          "nvim-dap-ui",
        },
      }
    end,
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local version = vim.version()

      dashboard.section.header.opts.hl = "@field";
      dashboard.section.header.val = {
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "                                                     ",
        string.format(
          "                        %d.%d.%d                        ",
          version.major, version.minor, version.patch
        ),
        "                                                     ",
        "                                                     ",
        "                                                     ",
      }

      local function button(key, label, cmd, hl)
        local b = dashboard.button(key, label, cmd)
        b.opts.hl = { { hl or "@string", 0, 5 } }
        b.opts.hl_shortcut = "@keyword"
        return b
      end

      dashboard.section.buttons.val = {
        button("e", "   New file", "<cmd>ene<cr>"),
        button("f", "   Finder", "<cmd>Telescope find_files<cr>"),
        button("t", " 󱏒  File Tree", "<cmd>ene<cr><cmd>Neotree toggle<cr>"),
        button("o", "   Restore", "<cmd>lua require('persistence').load()<cr>"),
        button("r", "   Recents", "<cmd>Telescope oldfiles<cr>"),
        button("p", "   Projects", "<cmd>Telescope projects<cr>"),
        { type = "padding", val = 0 },
        button("s", "   Settings", "<cmd>e $MYVIMRC<cr>", "@function"),
        button("l", " 󰒲  Lazy", "<cmd>Lazy<cr>", "@function"),
        button("m", "   Mason", "<cmd>Mason<cr>", "@function"),
        button("u", "   Update", "<cmd>TSUpdate<cr><cmd>Lazy sync<cr>", "@function"),
        { type = "padding", val = 0 },
        button("h", " 󰋠  Health", "<cmd>checkhealth<cr>", "DiagnosticError"),
        button("q", "   Quit", "<cmd>qa<cr>", "DiagnosticError"),
      }

      return dashboard
    end,
    config = function(_, dashboard)
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          dashboard.section.footer.val = {
            "",
            "",
            "⚡ Loaded " .. stats.count .. " plugins in " .. ms .. "ms ⚡",
          }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      throttle_ms = 200,
      handle = {
        text = " ",
        blend = 0,
        highlight = "lualine_b_normal"
      },
      handlers = {
        cursor = false,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = false,
        ale = false,
      },
    }
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim",        lazy = true },
}
