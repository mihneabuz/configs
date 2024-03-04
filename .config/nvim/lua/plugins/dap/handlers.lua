local M = {}

function M.sign_setup()
  vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "ErrorMsg", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = " ", texthl = "PmenuSel", linehl = "PmenuSel", numhl = "PmenuSel" })

  local old_place = vim.fn.sign_place
  local old_unplace = vim.fn.sign_unplace

  local hidden = nil
  local runner_group = ""

  vim.fn.sign_place = function(id, group, name, buf, args)
    if name == "DapStopped" then
      runner_group = group

      local placed = vim.fn.sign_getplaced(buf, { group = "dap_breakpoints", lnum = args.lnum })

      ---@diagnostic disable: undefined-field
      local breakpoint = placed[1].signs[1]

      if breakpoint then
        hidden = breakpoint
        hidden.buf = buf
        old_unplace("dap_breakpoints", { id = breakpoint.id })
      end
    end

    return args and old_place(id, group, name, buf, args) or old_place(id, group, name, buf)
  end

  vim.fn.sign_unplace = function(group, args)
    if group == runner_group and hidden then
      old_place(hidden.id, hidden.group, hidden.name, hidden.buf, { lnum = hidden.lnum, priority = hidden.priority })
    end

    return args and old_unplace(group, args) or old_unplace(group)
  end
end

function M.set_signcolumn()
  if package.loaded.neotest or #require("dap.breakpoints").get() > 0 then
    vim.cmd([[set signcolumn=yes:2]])
  else
    vim.cmd([[set signcolumn=yes:1]])
  end
end

function M.breakpoint()
  require("dap").toggle_breakpoint()
  M.set_signcolumn()
end

M.setup = {
  function(config)
    require("mason-nvim-dap").default_setup(config)
  end,
}

return M
