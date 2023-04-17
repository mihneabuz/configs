require 'user.base'
require 'user.keybinds'
require 'user.bootstrap'
require 'user.colorscheme'

local clean = os.getenv('NVIM_CLEAN')
if not clean then
  require 'user.treesitter'
  require 'user.autopairs'
  require 'user.comment'
  require 'user.lualine'
  require 'user.bufferline'
  require 'user.autocommands'
  require 'user.completion'
  require 'user.mason'
  require 'user.lsp'
  require 'user.misc'
  require 'user.dashboard'
  require 'user.neovide'
end
