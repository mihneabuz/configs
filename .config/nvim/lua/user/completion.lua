local success_cmp, cmp = pcall(require, "cmp")
if not success_cmp then
  return
end

local success_snip, luasnip = pcall(require, "luasnip")
if not success_snip then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmd_enabled = function()
	-- disable completion in comments
	local context = require 'cmp.config.context'
	-- keep command mode completion enabled when cursor is in a comment
	if vim.api.nvim_get_mode().mode == 'c' then
		return true
	else
		return not context.in_treesitter_capture("comment")
			and not context.in_syntax_group("Comment")
	end
end

local success_ts, _ = pcall(require, "nvim-treesitter")
if not success_ts then
	cmd_enabled = true
end

local format = function(entry, vim_item)
	vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
	vim_item.menu = ({
		nvim_lsp = "[LSP]",
		nvim_lua = "[NVIM]",
		luasnip = "[Snippet]",
		buffer = "[Buffer]",
		path = "[Path]",
	})[entry.source.name]
	return vim_item
end

local success_lspkind, lspkind = pcall(require, "lspkind")
if success_lspkind then
	format = lspkind.cmp_format({
		mode = 'symbol_text',
		maxwidth = 50,
		before = function (_, vim_item)
			return vim_item
		end
	})
end

local cmp_options = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },

    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
			elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  enabled = cmd_enabled,

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = format,
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },

  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}

cmp.setup(cmp_options)
