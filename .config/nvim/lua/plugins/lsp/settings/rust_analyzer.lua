return {
  settings = {
    ["rust_analyzer"] = {
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    }
  }
}
