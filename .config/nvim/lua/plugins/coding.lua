return {

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim"
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local kind = require("cmp.types").lsp.CompletionItemKind
      local kind_priority = {
        [kind.Keyword]     = 20,

        [kind.Field]       = 15,
        [kind.Variable]    = 15,
        [kind.Property]    = 15,
        [kind.Value]       = 15,

        [kind.Constructor] = 10,
        [kind.Method]      = 10,
        [kind.Function]    = 10,
        [kind.Operator]    = 10,

        [kind.Class]       = 8,
        [kind.Interface]   = 8,
        [kind.Struct]      = 8,
        [kind.Enum]        = 8,
        [kind.EnumMember]  = 8,
        [kind.Constant]    = 8,

        [kind.Snippet]     = 5,

        [kind.Folder]      = 3,
        [kind.File]        = 2,
      }

      local compare_kind = function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        if kind1 ~= kind2 then
          local prio1 = kind_priority[kind1] or 0
          local prio2 = kind_priority[kind2] or 0
          return prio1 > prio2
        end
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-.>"] = cmp.mapping.scroll_docs(-4),
          ["<C-,>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 50 },
          { name = "nvim_lua", priority = 40 },
          { name = "luasnip",  priority = 30 },
          { name = "path",     priority = 20 },
          { name = "buffer",   priority = 10 },
        }),
        formatting = {
          fields = { "kind", "abbr" },
          format = require("lspkind").cmp_format({
            mode = "symbol",
            elipsis_char = "…",
            before = function(_, item)
              item.abbr = string.sub(item.abbr, 1, 50)
              item.menu = nil
              return item
            end
          })
        },
        sorting = {
          comparators = {
            compare_kind,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.length,
          },
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      auto_close = true,
      use_diagnostic_signs = true
    },
    keys = {
      {
        "<leader>dd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Buffer diagnostics"
      },
      {
        "<leader>dw",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Workspace diagnostics"
      },
    },
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      { "gc",  desc = "Comment",     mode = { "n", "v" } },
      { "gcc", desc = "Comment line" },
    },
    main = "Comment",
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      }
    end
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    config = function()
      ---@diagnostic disable: inject-field
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup();
    end
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>",      desc = "Open terminal float", mode = { "n", "t" } },
      { [[<C-]>]], "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open terminal split", mode = { "n", "t" } },
    },
    cmd = "ToggleTerm",
    opts = {
      size = 20,
      hide_numbers = true,
      shading_factor = "2",
      direction = "float",
      shell = "fish -C fish_default_key_bindings",
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
      highlights = {
        NormalFloat = {
          link = "NormalFloat"
        },
        FloatBorder = {
          link = "FloatBorder"
        },
      },
    }
  },
}
