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

" jump to the last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" trim whitespace
autocmd BufWritePre * :%s/\s\+$//e

" save folds when closing file
augroup remember_folds
    autocmd!
    au BufWinLeave ?* mkview 1
    au BufWinEnter ?* silent! loadview 1
augroup END

" plugins
if filereadable(expand("~/.config/nvim/vimrc.plug"))
    source ~/.config/nvim/vimrc.plug
endif

" lua
if filereadable(expand("~/.config/nvim/lua/init.lua"))
    lua require('init')
endif
