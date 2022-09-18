--
-- Neovim lua configuration
--

-- plugins
require 'plugins'

-- theme
require 'theme.alpha'
require 'theme.lualine'
require 'theme.bufferline'
require 'theme.colors'

-- settings
require 'user.options'
require 'user.keymaps'
require 'user.autocmds'

-- plugins
require 'plug.nvtree'
require 'plug.telescope'
require 'plug.project'
require 'plug.treesitter'
require 'plug.toggleterm'
require 'plug.impatient'
require 'plug.indentline'
require 'plug.comment'
require 'plug.notify'
require 'plug.whichkey'
require 'plug.gitsigns'
require 'plug.dap'

-- lsp
require 'lsp.cmp'
require 'lsp.config'
require 'lsp.aerial'
