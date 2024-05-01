--
-- Neovim lua configuration
--

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
require 'config.lazy'
require 'config.colors'

-- library
require 'plug.guihua'

-- tags
require 'plug.tags'

-- telescope
require 'plug.telescope'
require 'plug.project'
require 'plug.treesitter'

-- git
require 'plug.gitsigns'

-- utils
require 'plug.illuminate'
require 'plug.notify'
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
--require 'plug.hardtime'

-- lsp
require 'lsp.cmp'
require 'lsp.config'
require 'lsp.aerial'
require 'lsp.null'
require 'lsp.lint'
