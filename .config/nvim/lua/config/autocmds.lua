local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "200" })
  end
})

-- auto resize windows
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- close some filetypes with <q>
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "grapple",
    "qf",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, nowait = true })
  end,
})

-- highlight trailling spaces
augroup("HighlightTraillingWhitespace", { clear = true })
autocmd("FileType", {
  group = "HighlightTraillingWhitespace",
  callback = function(ev)
    local ignored = {
      "alpha",
      "lazy",
      "mason",
      "grapple",
      "TelescopePrompt",
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "toggleterm",
      "man",
      "qf",
      "startuptime",
      "tsplayground",
      "checkhealth",
      "neo-tree",
      "filesystem"
    }

    if not vim.list_contains(ignored, ev.match) then
      vim.cmd([[match DiagnosticUnderlineHint /\s\+$/]])
    end
  end
})
