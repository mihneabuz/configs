return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    keys = {
      { "<c-space>", desc = "inc selection" },
      { "<bs>",      desc = "dec selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c", "cpp",
        "c_sharp",
        "css",
        "cuda",
        "d",
        "dart",
        "dockerfile",
        "fish",
        "go",
        "graphql",
        "haskell",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "make",
        "php",
        "prisma",
        "python",
        "ruby",
        "rust",
        "scala",
        "solidity",
        "toml",
        "typescript",
        "tsx",
        "vim",
        "yaml",
        "markdown",
        "markdown_inline",
        "query",
        "regex"
      },
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "function outer" },
            ["if"] = { query = "@function.inner", desc = "function inner" },

            ["ac"] = { query = "@class.outer", desc = "class outer" },
            ["ic"] = { query = "@class.inner", desc = "class inner" },
          },
        }
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "AckslD/nvim-trevJ.lua",
    keys = {
      { "<leader>J", function() require("trevj").format_at_cursor() end, desc = "reverse J" },
    },
    config = true
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    keys = {
      { "za", desc = "toggle fold" },
      { "zM", function() require("ufo").openAllFolds() end,  desc = "open all folds" },
      { "zN", function() require("ufo").closeAllFolds() end, desc = "close all folds" },
    },
    main = "ufo",
    opts = {
      open_fold_hl_timeout = 100,
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  󱞦 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
    }
  },

  {
    "mizlan/iswap.nvim",
    keys = {
      { "gs", "<cmd>ISwapNodeWith<cr>", desc = "swap param" }
    },
    config = true
  },
}
