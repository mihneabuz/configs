return {

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
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
        "hcl",
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
        "vimdoc",
        "yaml",
        "markdown",
        "markdown_inline",
        "query",
        "regex"
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
  },

  {
    "AckslD/nvim-trevJ.lua",
    keys = {
      { "<leader>J", function() require("trevj").format_at_cursor() end, desc = "Expand line" },
    },
    config = true
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    keys = {
      { "za", desc = "Toggle fold" },
      { "zM", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
      { "zN", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    },
    main = "ufo",
    opts = {
      open_fold_hl_timeout = 100,
      provider_selector = function(_, _, _)
        return { "treesitter" }
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
      { "gs", "<cmd>ISwapNodeWith<cr>", desc = "Swap parameter" }
    },
    config = true
  },
}
