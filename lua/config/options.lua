-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable LazyVim auto format
vim.g.autoformat = false

local opt = vim.opt
local undodir = os.getenv( "HOME" ) .. '/.cache/nvim/undo'

vim.cmd [[
    let g:loaded_ruby_provider = 0               " Disable ruby provider
    let g:loaded_node_provider = 0               " Disable node provider
    let g:loaded_perl_provider = 0               " Disable perl provider
]]

vim.cmd [[
    filetype off                                " Force plug-ins to load correctly.
    filetype plugin indent on                   " For plug-ins to load correctly.
    syntax on                                   " Syntax highlightings
]]

-- Lazy common
opt.mouse = "a"                                 -- Enable mouse
opt.signcolumn = "auto"                         -- Draw sign column
opt.number = true                               -- Print line numbers
opt.cursorline = true                           -- Show cursor line
opt.clipboard = "unnamedplus"                   -- Send yank to system clipboard
opt.showmode = false                            -- Print current mode
opt.autowrite = true                            -- Automatically save before :next and :make
opt.completeopt = "menu,menuone,preview"        -- Vim popup menu behavior
opt.conceallevel = 0                            -- So that `` is visible in markdown files
opt.expandtab = true                            -- Convert tabs to spaces
opt.ignorecase = true                           -- Do case insensitive matching
opt.laststatus = 2                              -- Always print status line
opt.smartcase = true                            -- Do smart case matching
opt.smartindent = true                          -- Make indenting smarter again
opt.tabstop = 4                                 -- Insert 4 spaces for a tab
opt.shiftwidth = 4                              -- Number of spaces inserted for each indentation
opt.softtabstop = 4                             -- Number of spaces that a tab count
opt.shiftround = true                           -- Round indent
opt.splitbelow = true                           -- Horizontal splits to go below current window
opt.splitright = true                           -- Vertical splits to go to the right of current window
opt.scrolloff = 4                               -- Lines of context
opt.sidescrolloff = 8                           -- Columns of context
opt.list = true                                 -- Enable list mode
opt.relativenumber = true                       -- Line numbers relative to cursor
opt.pumheight = 10                              -- Pop up menu height
opt.pumblend = 10                               -- Popup blend from 0 to 100
opt.inccommand = "nosplit"                      -- Preview incremental substitute
opt.confirm = true                              -- Confirm to save changes before exiting modified buffer
opt.undofile = true                             -- Persistent undo
opt.undodir = undodir                           -- Undo directory
opt.undolevels = 10000                          -- Maximum number of changes that can be undone
opt.undoreload = 100000                         -- Maximum number lines to save for undo on reload
opt.updatetime = 100                            -- Reduce update time for async update
opt.wildmenu = true                             -- Activate wildmenu
opt.wildmode = "longest:full,full"              -- Vim bar autocomplete, alt: longest,list,full
opt.winminwidth = 5                             -- Minimum window width
opt.foldlevel = 0                               -- Folding
opt.foldmethod = "expr"                         -- Use syntax based folding method
opt.foldexpr = "nvim_treesitter#foldexpr()"     -- Use Treesitter folding
opt.formatoptions = "tcqjrol"                   -- Auto format options, default: tcqj
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shortmess:append({ W = true, c = true, C = true })
opt.spelllang = { "en" }                        -- List of spell lang

-- Lazy only
--opt.grepformat = "%f:%l:%c:%m"
--opt.grepprg = "rg --vimgrep"
--opt.splitkeep = "screen"

-- Custom
opt.compatible = false                          -- Set compatibility to Vim only.
opt.magic = true                                -- Magic pattern
opt.keymodel = "startsel"                       -- Shift+arrow selection
opt.ruler = true                                -- Show the cursor position all the time
opt.showcmd = true                              -- Show (partial) command in status line.
opt.showmatch = true                            -- Show matching brackets.
opt.ttyfast = true                              -- Indicate fast terminal conn for faster redraw
opt.incsearch = true                            -- Incremental search
opt.hlsearch = true                             -- Colorize search
opt.autoread = true                             -- Update when a file's read-only state is changed
opt.hidden = true                               -- Hide buffers when they are abandoned
opt.backup = false                              -- No backup file
opt.history = 1000                              -- keep 1000 lines of command history
opt.backspace = "indent,eol,start"              -- Activate backspace
opt.matchpairs = "(:),{:},[:],<:>"              -- Highlight pairs of brackets, use '%' char to jump.
opt.swapfile = false                            -- swap files give annoying warning
opt.directory= "/tmp"                           -- Directory used for storing temp files
opt.textwidth = 0                               -- Disable max line width
opt.cmdheight = 1                               -- More space in the neovim cmd line for displaying messages

-- Others
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.wildignore:append "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif"
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
