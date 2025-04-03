return {
  {
    "akinsho/bufferline.nvim",
    version = false,
    event = "VeryLazy",
    dependencies = { "lualine.nvim" },
    keys = {
      { "<S-l>",     "<cmd>keepjumps BufferLineCycleNext<cr>",       desc = "Next buffer" },
      { "<S-h>",     "<cmd>keepjumps BufferLineCyclePrev<cr>",       desc = "Prev buffer" },
      { "<leader>B", "<cmd>keepjumps BufferLineSortByExtension<cr>", desc = "Sort buffers" },
      { "<leader>b", "<cmd>keepjumps BufferLinePick<cr>",            desc = "Pick buffer" },
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
        if #clients == 0 then
          return ""
        end

        local names = {}
        for i = #clients, 1, -1 do
          names[#names + 1] = clients[i]["name"]
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
          lualine_a = { { "mode", fmt = mode_fmt } },
          lualine_b = { diagnostics, "branch", "diff" },
          lualine_c = { filetype, filename, mark },
          lualine_x = { lsp },
          lualine_y = { "location" },
          lualine_z = { time },
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
