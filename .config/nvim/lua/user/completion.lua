local success_cmp, cmp = pcall(require, "cmp")
if not success_cmp then
  return
end

local success_snip, luasnip = pcall(require, "luasnip")
if not success_snip then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
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
  local context = require('cmp.config.context')
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
    before = function(_, vim_item)
      return vim_item
    end
  })
end

local types = require('cmp.types')
local compare_kind = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Snippet then
      return false
    end

    if kind2 == types.lsp.CompletionItemKind.Snippet then
      return true
    end
  end
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
      elseif has_words_before() then
        cmp.complete()
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

  sorting = {
    comparators = {
      compare_kind,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.length,
    },
  },
}

cmp.setup(cmp_options)
