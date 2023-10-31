return {

  -- general commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      { "<leader>gs",  "<cmd>Git status<cr>",        desc = "git status" },
      { "<leader>gdd", "<cmd>Git diff<cr>",          desc = "git diff" },
      { "<leader>gds", "<cmd>Git diff --staged<cr>", desc = "git staged" },
      { "<leader>gc",  "<cmd>Git diff --staged<cr>", desc = "git staged" },
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
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        keymap("n", "]h", gs.next_hunk, "next hunk")
        keymap("n", "[h", gs.prev_hunk, "nrev hunk")
        keymap("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", "git stage hunk")
        keymap("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "git seset hunk")
        keymap("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "blame line")
        keymap("n", "<leader>ghd", gs.diffthis, "git diff")
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

      local keymap = vim.api.nvim_set_keymap
      local silent = { noremap = true, silent = true }

      keymap("n", "<leader>mg", "<cmd>diffget<cr>", silent)
      keymap("n", "<leader>mp", "<cmd>diffput<cr>", silent)
    end
  },
}
