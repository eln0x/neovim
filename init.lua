--
-- Neovim lua configuration
--

-- ensure pynvim is installed
vim.cmd [[
    if !has('python3')
        echohl WarningMsg
        echo 'Missing python3 support - need to pip install pynvim'
        echohl None
    endif
]]

---- plugins
--require 'plugins'
--
---- theme
--require 'theme.alpha'
--require 'theme.lualine'
--require 'theme.bufferline'
--require 'theme.colors'
--
---- settings
--require 'user.options'
--require 'user.keymaps'
--require 'user.autocmds'
--
---- plugins
--require 'plug.guihua'
--require 'plug.nvtree'
--require 'plug.telescope'
--require 'plug.project'
--require 'plug.treesitter'
--require 'plug.toggleterm'
--require 'plug.impatient'
--require 'plug.indentline'
--require 'plug.comment'
--require 'plug.notify'
--require 'plug.whichkey'
--require 'plug.gitsigns'
--require 'plug.dap'
--require 'plug.tags'
--require 'plug.golang'
--
---- lsp
--require 'lsp.cmp'
--require 'lsp.config'
--require 'lsp.aerial'
--require 'lsp.null'
