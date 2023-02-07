local success, configs = pcall(require, "nvim-treesitter.configs")
if not success then
    return
end

configs.setup {
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
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },
  sync_install = false,
	autopairs = {
    enable = true,
	},
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
	context_commentstring = {
		enable = true,
		enable_autocmd = false
	},
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
