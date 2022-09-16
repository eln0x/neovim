--
-- NeoVim common
--
local opt = vim.opt
local undodir = os.getenv( "HOME" ) .. '/.cache/nvim/undo'

opt.mouse = "a"                                 -- Enable mouse
opt.compatible = false                          -- Set compatibility to Vim only.
opt.magic = true                                -- Magic pattern
opt.signcolumn = "auto"                         -- Draw sign column
opt.number = true                               -- Print line numbers
opt.relativenumber = true                       -- Line numbers relative to cursor
opt.cursorline = true                           -- Show cursor line
opt.clipboard = "unnamedplus"                   -- Send yank to system clipboard
opt.keymodel = "startsel"                       -- Shift+arrow selection
opt.ruler = true                                -- Show the cursor position all the time
opt.showmode = true                             -- Print current mode
opt.showcmd = true                              -- Show (partial) command in status line.
opt.showmatch = true                            -- Show matching brackets.
opt.ttyfast = true                              -- Indicate fast terminal conn for faster redraw
opt.ignorecase = true                           -- Do case insensitive matching
opt.smartcase = true                            -- Do smart case matching
opt.incsearch = true                            -- Incremental search
opt.hlsearch = true                             -- Colorize search
opt.autowrite = true                            -- Automatically save before :next and :make
opt.autoread = true                             -- Update when a file's read-only state is changed
opt.hidden = true                               -- Hide buffers when they are abandoned
opt.backup = false                              -- No backup file
opt.undodir = undodir                           -- Undo directory
opt.undofile = true                             -- Persistent undo
opt.undolevels = 10000                          -- Maximum number of changes that can be undone
opt.undoreload = 100000                         -- Maximum number lines to save for undo on reload
opt.history = 1000                              -- keep 1000 lines of command history
opt.foldmethod = "syntax"                       -- Use syntax based folding method
opt.backspace = "indent,eol,start"              -- Activate backspace
opt.laststatus = 2                              -- Always print status line
opt.wildmenu = true                             -- Activate wildmenu
opt.wildmode = "longest:full,full"              -- Vim bar autocomplete, alt: longest,list,full
opt.completeopt = "menu,preview"                -- Vim popup menu behavior
opt.matchpairs = "(:),{:},[:],<:>"              -- Highlight pairs of brackets, use '%' char to jump.
opt.swapfile = false                            -- swap files give annoying warning
opt.directory= "/tmp"                           -- Directory used for storing temp files
opt.updatetime = 100                            -- Reduce update time for async update
opt.fileencoding = "utf-8"                      -- Encoding written to a file
opt.smartindent = true                          -- Make indenting smarter again
opt.tabstop = 4                                 -- Insert 4 spaces for a tab
opt.shiftwidth = 4                              -- Number of spaces inserted for each indentation
opt.softtabstop = 4                             -- Number of spaces that a tab count
opt.textwidth = 0                               -- Disable max line width
opt.expandtab = true                            -- Convert tabs to spaces
opt.shortmess:append "c"                        -- Don't give ins-completion-menu messages
opt.pumheight = 10                              -- Pop up menu height
opt.splitbelow = true                           -- Horizontal splits to go below current window
opt.splitright = true                           -- Vertical splits to go to the right of current window
opt.list = true                                 -- Enable list mode
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.wildignore:append "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
