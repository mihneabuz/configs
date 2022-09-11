local success, toggleterm = pcall(require, "toggleterm")
if not success then
  return
end

toggleterm.setup({
  size = 20,
  hide_numbers = true,
  shade_terminals = false,
  start_in_insert = true,
  open_mapping = [[<c-\>]],
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = '/bin/fish',
  auto_scroll = true,
  float_opts = {
    border = "solid",
    winblend = 0,
  },
  highlights = {
    NormalFloat = {
      link = 'TabLine'
    },
    FloatBorder = {
      link = 'TabLine'
    },
  },
})
