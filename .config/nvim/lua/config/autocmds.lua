local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "200" })
  end
})

-- auto resize windows
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- enable wrap and spellcheck for text files
autocmd("FileType", {
  group = augroup("WrapSpellText", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- highlight trailling spaces
autocmd("BufRead", {
  group = augroup("HighlightTraillingWhitespace", { clear = true }),
  callback = function()
    vim.cmd([[match DiagnosticUnderlineHint /\s\+$/]])
  end
})
