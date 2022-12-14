local success, bufferline = pcall(require, "bufferline")
if not success then
  return
end

bufferline.setup({
  options = {
    numbers = "none",
    right_mouse_command  = nil,
    left_mouse_command   = nil,
    middle_mouse_command = nil,
    indicator = { icon = "▎" },
    modified_icon = "",
    max_name_length = 20,
    max_prefix_length = 6,
		enforce_regular_tabs = false,
    diagnostics = false,
    offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				padding = 1,
				highlight = "BufferLineFill"
			}
		},
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = { "", "" },
    always_show_bufferline = true,
  },
  highlights = {
		fill = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
		background = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
    tab_selected = {
			fg = { attribute = "fg", highlight = "Function" },
		},

		buffer_selected = {
			bg = { attribute = "bg", highlight = "lualine_b_normal" },
			fg = { attribute = "fg", highlight = "Function" },
			bold = true
		},
    indicator_selected = {
			bg = { attribute = "bg", highlight = "lualine_b_normal" },
			fg = { attribute = "fg", highlight = "Function" },
    },
    modified_selected = {
			bg = { attribute = "bg", highlight = "lualine_b_normal" },
      fg = { attribute = "fg", highlight = "Type" },
    },

		buffer_visible = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
		indicator_visible = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
    modified_visible = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
      fg = { attribute = "fg", highlight = "Type" },
    },

    modified = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
      fg = { attribute = "fg", highlight = "Type" },
    },

    separator = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
    },
    separator_selected = {
			bg = { attribute = "bg", highlight = "lualine_c_normal" },
    },
  },
})
