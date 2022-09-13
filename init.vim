"
" NeoVim Configuration
"

" ensure pynvim is installed
if !has('python3')
    echohl WarningMsg
    echo 'Missing python3 support - need to pip install pynvim'
    echohl None
endif

" common
filetype off                            " Force plug-ins to load correctly.
filetype plugin indent on               " For plug-ins to load correctly.
syntax on                               " Syntax highlightings

" plugins
if filereadable(expand("~/.config/nvim/vimrc.plug"))
    source ~/.config/nvim/vimrc.plug
endif

" lua
if filereadable(expand("~/.config/nvim/lua/init.lua"))
    lua require('init')
endif

" mappings
let mapleader = " "                     " Leader key set to <space bar>
