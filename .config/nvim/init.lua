require 'user.impacient'
require 'user.base'
require 'user.keybinds'
require 'user.colorscheme'
require 'user.bootstrap'

local clean = os.getenv('NVIM_CLEAN')
if not clean then
  require 'user.misc'
  require 'user.completion'
  require 'user.lsp'
  require 'user.treesitter'
  require 'user.autopairs'
  require 'user.comment'
  require 'user.git'
  require 'user.lualine'
  require 'user.bufferline'
  require 'user.autocommands'
  require 'user.neovide'
end
