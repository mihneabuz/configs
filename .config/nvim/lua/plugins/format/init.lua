return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>F", function() require("plugins.format.handlers").format() end, mode = { "n", "v" }, desc = "Format file" }
    },
    opts = {
      formatters_by_ft = {
        ["_"] = { "trim_whitespace" }
      }
    },
  },
}
