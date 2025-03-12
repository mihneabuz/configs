return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>f", function() require("plugins.format.handlers").format() end, mode = { "n", "v" }, desc = "Format file" }
    },
    config = true
  },
}
