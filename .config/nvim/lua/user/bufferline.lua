local success, bufferline = pcall(require, "bufferline")
if not success then
  return
end

bufferline.setup({
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
        filetype = "NvimTree",
        text = "File Explorer",
        padding = 1,
        highlight = "BufferLineFill"
      }
    },
    show_buffer_icons       = true,
    show_buffer_close_icons = false,
    show_close_icon         = false,
    show_tab_indicators     = true,
    persist_buffer_sort     = true,
    separator_style         = {},
    always_show_bufferline  = false,
  },
  highlights = BufferlineTheme,
})
