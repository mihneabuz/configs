return {

  -- snippets
  {
    "L3MON4D3/LuaSnip",
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
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim"
    },
    opts = function()
      local cmp = require("cmp")

      local format = require("lspkind").cmp_format({
        mode = "symbol_text",
        elipsis_char = "..",
        before = function(_, item)
          item.abbr = string.sub(item.abbr, 1, 32)
          item.menu = nil
          return item
        end
      })

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 50 },
          { name = "nvim_lua", priority = 40 },
          { name = "luasnip",  priority = 30 },
          { name = "path",     priority = 20 },
          { name = "buffer" },
        }),
        formatting = {
          fields = { "kind", "abbr" },
          format = format
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
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "document diagnostics" },
      { "<leader>dD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace diagnostics" },
      { "<leader>dQ", "<cmd>TroubleToggle loclist<cr>",               desc = "location list" },
      { "<leader>dq", "<cmd>TroubleToggle quickfix<cr>",              desc = "quickfix list" },
      {
        "[d",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "prev trouble",
      },
      {
        "]d",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "next trouble",
      },
    },
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    config = true
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      { "gc",  desc = "comment",     mode = { "n", "v" } },
      { "gcc", desc = "comment line" },
    },
    main = "Comment",
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      }
    end
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>",      desc = "terminal float",  mode = { "n", "t" } },
      { [[<C-]>]], "<cmd>ToggleTerm direction=horizontal<cr>", desc = "terminal bottom", mode = { "n", "t" } },
    },
    cmd = "ToggleTerm",
    opts = {
      size = 20,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = "2",
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = "fish",
      auto_scroll = true,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
    }
  },
}
