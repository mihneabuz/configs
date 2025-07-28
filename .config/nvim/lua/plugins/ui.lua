return {
  {
    "akinsho/bufferline.nvim",
    version = false,
    event = "VeryLazy",
    keys = {
      { "gn",        "<cmd>BufferLineCycleNext<cr>",       desc = "Next buffer" },
      { "gp",        "<cmd>BufferLineCyclePrev<cr>",       desc = "Prev buffer" },
      { "<leader>B", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort buffers" },
      { "<leader>b", "<cmd>BufferLinePick<cr>",            desc = "Pick buffer" },
    },
    opts = {
      options = {
        numbers                 = "none",
        right_mouse_command     = nil,
        left_mouse_command      = nil,
        middle_mouse_command    = nil,
        indicator               = { icon = "▐" },
        modified_icon           = "󰏫",
        max_name_length         = 28,
        max_prefix_length       = 12,
        enforce_regular_tabs    = false,
        diagnostics             = false,
        show_buffer_icons       = true,
        show_buffer_close_icons = false,
        show_close_icon         = false,
        show_tab_indicators     = false,
        persist_buffer_sort     = true,
        separator_style         = {},
        always_show_bufferline  = false,
        left_trunc_marker       = "",
        right_trunc_marker      = "",
        custom_areas            = {
          right = function()
            local total = #vim.api.nvim_list_tabpages()
            return total < 2 and {}
                or { {
                  text = vim.api.nvim_get_current_tabpage() .. "  " .. total .. " ",
                  fg = vim.api.nvim_get_hl(0, { name = "@function" }).fg
                } }
          end,
        }
      },
      highlights = require("themes").default.bufferline,
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("themes").icons.diagnostics

      local diagnostics = {
        "diagnostics",
        sources          = { "nvim_diagnostic" },
        sections         = { "error", "warn" },
        symbols          = { error = icons.ERROR .. " ", warn = icons.WARN .. " " },
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
          modified = "󰏫 ",
          readonly = " ",
          unnamed = "",
          newfile = ""
        }
      }

      local mode_fmt = function(mode)
        return mode .. string.rep(" ", 7 - string.len(mode))
      end

      local mark = function()
        return vim.bo.buftype ~= "nofile"
            and require("grapple").exists({ buffer = 0 })
            and " " or ""
      end

      local lsp = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local names = vim.tbl_map(function(client) return client["name"] end, clients)
        return #names > 0
            and string.format(" LSP [%s]", table.concat(names, ", "))
            or ""
      end

      return {
        options = {
          theme                = require("themes").default.lualine,
          globalstatus         = true,
          always_divide_middle = true,
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          disabled_filetypes   = {
            statusline = { "dashboard", "alpha" }
          },
        },
        sections = {
          lualine_a = { { "mode", fmt = mode_fmt } },
          lualine_b = { diagnostics, "branch" },
          lualine_c = { filetype, filename, mark, "diff" },
          lualine_x = { lsp },
          lualine_y = { "encoding", "filesize" },
          lualine_z = { "location" },
        },
        extensions = { "lazy", },
      }
    end,
  },

  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton"
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
