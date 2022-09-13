"
" NeoVim Configuration
"

" ensure pynvim is installed
if !has('python3')
    echohl WarningMsg
    echo 'Missing python3 support - need to pip install pynvim'
    echohl None
endif

" colorscheme
colorscheme jellybeans                  " Preferred color scheme
set termguicolors                       " Set term gui colors
set background=dark                     " Select dark background

" common
filetype off                            " Force plug-ins to load correctly.
filetype plugin indent on               " For plug-ins to load correctly.
syntax on                               " Syntax highlightings

" options
set mouse=a                             " Enable mouse
set nocompatible                        " Set compatibility to Vim only.
set magic                               " Magic pattern
set signcolumn=auto                     " Draw sign column
set number                              " Print line numbers
set relativenumber                      " Line numbers relative to cursor
set cursorline                          " Show cursor line
set clipboard^=unnamedplus              " Send yank to system clipboard
set keymodel=startsel                   " Shift+arrow selection
set ruler                               " Show the cursor position all the time
set showmode                            " Print current mode
set showcmd                             " Show (partial) command in status line.
set showmatch                           " Show matching brackets.
set ttyfast                             " Indicate fast terminal conn for faster redraw
set ignorecase                          " Do case insensitive matching
set smartcase                           " Do smart case matching
set incsearch                           " Incremental search
set hlsearch                            " Colorize search
set autowrite                           " Automatically save before :next and :make
set autoread                            " Update when a file's read-only state is changed
set hidden                              " Hide buffers when they are abandoned
set nobackup                            " No backup file
set undodir=~/.cache/nvim/undo          " Undo directory
set undofile                            " Persistent undo
set undolevels=10000                    " Maximum number of changes that can be undone
set undoreload=100000                   " Maximum number lines to save for undo on reload
set history=1000                        " keep 1000 lines of command history
set foldmethod=syntax                   " Use syntax based folding method
set backspace=indent,eol,start          " Activate backspace
set laststatus=2                        " Always print status line
set wildmenu                            " Activate wildmenu
set wildmode=longest:full,full          " Bar autocomplete, alt: longest,list,full
set completeopt=menu,preview            " Popup menu behavior
set matchpairs+=<:>                     " Highlight pairs of brackets, use '%' char to jump.
set noswapfile                          " swap files give annoying warning
set directory=/tmp                      " Directory used for storing temp files
set updatetime=100                      " Reduce update time for async update
set fileencoding=utf-8                  " Encoding written to a file
set smartindent                         " Make indenting smarter again
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Number of spaces inserted for each indentation
set softtabstop=4                       " Number of spaces that a tab count
set textwidth=0                         " Disable max line width
set expandtab                           " Convert tabs to spaces
set shortmess+=c                        " Don't give ins-completion-menu messages
set pumheight=10                        " Pop up menu height
set splitbelow                          " Horizontal splits to go below current window
set splitright                          " Vertical splits to go to the right of current window
set list                                " Enable list mode
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif

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
