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
    indicator_icon = "▎",
    modified_icon = "",
    max_name_length = 18,
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
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
		background = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
    tab_selected = {
			guifg = { attribute = "fg", highlight = "Function" },
		},

		buffer_selected = {
			guibg = { attribute = "bg", highlight = "lualine_b_normal" },
			guifg = { attribute = "fg", highlight = "Function" },
			gui = "bold"
		},
    indicator_selected = {
			guibg = { attribute = "bg", highlight = "lualine_b_normal" },
			guifg = { attribute = "fg", highlight = "Function" },
    },
    modified_selected = {
			guibg = { attribute = "bg", highlight = "lualine_b_normal" },
      guifg = { attribute = "fg", highlight = "Type" },
    },

		buffer_visible = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
		indicator_visible = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
		},
    modified_visible = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
      guifg = { attribute = "fg", highlight = "Type" },
    },

    modified = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
      guifg = { attribute = "fg", highlight = "Type" },
    },

    separator = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
    },
    separator_selected = {
			guibg = { attribute = "bg", highlight = "lualine_c_normal" },
    },
  },
})
