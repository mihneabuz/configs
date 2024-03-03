return {

  -- general commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      { "<leader>gs", "<cmd>Git status<cr>", desc = "Status" },
      { "<leader>gd", "<cmd>Git diff<cr>",   desc = "Diff" },
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "🭲" },
        change       = { text = "🭲" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "🭲" },
        untracked    = { text = "🭲" },
      },
      sign_priority = 10,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function keymap(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { silent = true, buffer = buffer, desc = desc })
        end

        keymap("n", "]h", gs.next_hunk, "Next git hunk")
        keymap("n", "[h", gs.prev_hunk, "Prev git hunk")
        keymap("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        keymap("n", "<leader>gh", "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk")
        keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk")
      end,
      trouble = false,
    },
  },

  -- mergetool
  {
    "samoshkin/vim-mergetool",
    cmd = { "MergetoolStart", "MergetoolStop", "MergetoolToggle" },
    config = function()
      vim.cmd([[
        let g:mergetool_layout = "mr"
        let g:mergetool_prefer_revision = "local"
      ]])

      require('which-key').register({
        ['<leader>m'] = { name = 'Mergetool', _ = 'which_key_ignore' },
      })

      local function keymap(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { noremap = true, silent = true, desc = desc })
      end

      keymap("n", "<leader>mg", "<cmd>diffget<cr>", "Diff get")
      keymap("n", "<leader>mp", "<cmd>diffput<cr>", "Diff put")
    end
  },
}
