local success, dap = pcall(require, "dap")
if not success then
  return
end

local keymap = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

keymap("n", "<leader>D", ":lua require'dap'.toggle_breakpoint()<CR>", silent)

local success, mason_dap = pcall(require, "mason-nvim-dap")
if success then
  mason_dap.setup({
      automatic_setup = true,
  })

  mason_dap.setup_handlers({
    function(source_name)
      vim.notify(source_name)
      mason_dap.automatic_setup(source_name)
    end,
  })
end

local success, dapui = pcall(require, "dapui")
if success then
  dapui.setup()
end
