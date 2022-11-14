local success, test = pcall(require, "nvim-test")
if not success then
  return
end

test.setup({
  run = true,
  commands_create = true,
  filename_modifier = ":p",
  silent = false,
  term = "toggleterm",
  termOpts = {
    direction = "float",
    go_back = false,
    stopinsert = true,
    keep_one = true,
  },
})
