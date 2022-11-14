local success_signature, signature = pcall(require, "lsp_signature")
if success_signature then
  signature.setup({
    hint_enable = false,
    doc_lines = 0,
    transparency = 10,
    timer_interval = 300,
    handler_opts = { border = "rounded" }
  })
end

local success_lightbulb, lightbulb = pcall(require, "nvim-lightbulb")
if success_lightbulb then
  lightbulb.setup({
    ignore = { "null-ls" },
    autocmd = { enabled = true },
    sign = {
      enabled = true,
      priority = 50
    }
  })
end
