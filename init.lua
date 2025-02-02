--
-- Neovim lua configuration
--

-- reduce lua diagnostic noise
local vim = vim

-- encoding written to a file
vim.opt.fileencoding = 'utf-8'

-- ensure pynvim is installed
vim.cmd [[
    if !has('python3')
        echohl WarningMsg
        echo 'Missing python3 support - need to pip install pynvim'
        echohl None
    endif
]]

-- settings
require 'config.keymaps'
require 'config.autocmds'
require 'config.options'
require 'config.plugins'
require 'config.colors'

-- ui
require 'ui.colors'
require 'ui.alpha'
require 'ui.bufferline'
require 'ui.lualine'
require 'ui.indentline'
require 'ui.indentscope'
require 'ui.notify'
require 'ui.noice'
require 'ui.dressing'
require 'ui.guihua'

require 'theme.illuminate'

-- tags
require 'plug.tags'

-- telescope
require 'plug.telescope'
require 'plug.project'
require 'plug.treesitter'

-- git
require 'plug.gitsigns'

-- utils
require 'plug.persistence'
require 'plug.impatient'
require 'plug.nvtree'
require 'plug.whichkey'
require 'plug.toggleterm'
require 'plug.comment'
require 'plug.golang'
require 'plug.dap'
require 'plug.todos'
require 'plug.trouble'
require 'plug.flash'
require 'plug.spectre'
require 'plug.hardtime'

-- lsp
require 'lsp.cmp'
require 'lsp.config'
require 'lsp.aerial'
require 'lsp.null'
require 'lsp.lint'

-- vim: ts=4 sts=4 sw=4 et
