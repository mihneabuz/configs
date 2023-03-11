local success_mason, mason = pcall(require, "mason")
if not success_mason then
  return
end

mason.setup()

local success_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if success_lsp then
  mason_lsp.setup({
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "gopls",
      "clangd",
      "pyright",
      "tsserver", "emmet_ls", "jsonls", "cssls", "tailwindcss"
    },
    automatic_installation = true,
  })
end

local success_dap, mason_dap = pcall(require, "mason-nvim-dap")
if success_dap then
  mason_dap.setup({
    ensure_installed = { "lldb", "delve", "python" },
    automatic_setup = true,
  })
end
