--
-- Neovim lua configuration
--

-- common
require 'user.colors'
require 'user.options'
require 'user.autocmds'
require 'user.keymaps'

-- plugins
require 'plug.alpha'
require 'plug.nvtree'
require 'plug.telescope'
require 'plug.project'
require 'plug.treesitter'

-- lsp
require 'lsp.cmp'
require 'lsp.config'
