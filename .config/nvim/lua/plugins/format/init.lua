return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>F", function() require("plugins.format.handlers").format() end, mode = { "n", "v" }, desc = "Format file" }
  },
  opts = {},
}
