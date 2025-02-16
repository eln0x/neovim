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
require 'ui.alpha'
require 'ui.bufferline'
require 'ui.lualine'
require 'ui.indentline'
require 'ui.indentscope'
require 'ui.notify'
require 'ui.noice'
require 'ui.dressing'
require 'ui.guihua'

-- editor
require 'editor.whichkey'
require 'editor.nvtree'
require 'editor.telescope'
require 'editor.illuminate'
require 'editor.todos'
require 'editor.gitsigns'
require 'editor.spectre'
require 'editor.flash'
require 'editor.aerial'
require 'editor.trouble'
require 'editor.toggleterm'

-- coding
require 'code.cmp'
require 'code.comment'
require 'code.golang'
require 'code.syntax'
require 'code.context'

-- lsp
require 'lsp.config'
require 'lsp.mason'
require 'lsp.null'
require 'lsp.dap'
require 'lsp.lint'

-- utils
require 'utils.project'
require 'utils.persistence'
require 'utils.impatient'

-- vim: ts=4 sts=4 sw=4 et
