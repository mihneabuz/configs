return {

  -- git signs and commands
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "" },
        untracked    = { text = "▎" },
      },
      preview_config = {
        border = "rounded"
      },
      sign_priority = 10,
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function keymap(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { silent = true, buffer = buffer, desc = desc })
        end

        keymap("n", "]h", gs.next_hunk, "Next git hunk")
        keymap("n", "[h", gs.prev_hunk, "Prev git hunk")

        keymap("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")

        keymap("n", "<leader>gl", function() gs.preview_hunk() end, "Preview hunk floating")
        keymap("n", "<leader>gi", function() gs.preview_hunk_inline() end, "Preview hunk inline")

        keymap("n", "<leader>gs", function() gs.stage_hunk() end, "Stage hunk")
        keymap("n", "<leader>gr", function() gs.reset_hunk() end, "Reset hunk")
        keymap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Stage hunk")
        keymap("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Reset hunk")

        keymap("n", "<leader>gS", function() gs.stage_hunk() end, "Stage buffer")
        keymap("n", "<leader>gR", function() gs.reset_hunk() end, "Reset buffer")

        keymap("n", "<leader>gu", function() gs.undo_stage_hunk() end, "Undo last stage")
      end,
      trouble = false,
    },
  },

  -- mergetool
  {
    "samoshkin/vim-mergetool",
    cmd = { "MergetoolStart", "MergetoolStop", "MergetoolToggle" },
    config = function()
      ---@diagnostic disable: inject-field
      vim.g.mergetool_layout = "mr"
      vim.g.mergetool_prefer_revision = "local"

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
