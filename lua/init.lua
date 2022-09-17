--
-- Neovim lua configuration
--

-- plugins
require 'plugins'

-- common
require 'user.colors'
require 'user.options'
require 'user.keymaps'
require 'user.autocmds'

-- plugins
require 'plug.alpha'
require 'plug.nvtree'
require 'plug.telescope'
require 'plug.project'
require 'plug.treesitter'
require 'plug.toggleterm'
require 'plug.impatient'
require 'plug.indentline'
require 'plug.notify'
require 'plug.whichkey'

-- lsp
require 'lsp.cmp'
require 'lsp.config'
require 'lsp.aerial'
