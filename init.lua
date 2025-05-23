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
require 'config.lazy'
require 'config.options'
require 'config.colors'

-- vim: ts=4 sts=4 sw=4 et
