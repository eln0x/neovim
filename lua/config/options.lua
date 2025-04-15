-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Providers
vim.g.loaded_ruby_provider = 0                  -- Disable ruby provider
vim.g.loaded_node_provider = 0                  -- Disable node provider
vim.g.loaded_perl_provider = 0                  -- Disable perl provider

-- Behavior
vim.g.autoformat = false                        -- Disable LazyVim auto format
vim.g.deprecation_warnings = false              -- Hide deprecation warnings
vim.g.snacks_animate = true                     -- Snacks animations
vim.g.trouble_lualine = true                    -- Show the current document symbols
vim.g.markdown_recommended_style = 0            -- Fix markdown indentation settings

-- Options
local opt = vim.opt
local undodir = os.getenv( "HOME" ) .. '/.cache/nvim/undo'

-- common
opt.autoread = true                             -- Update when a file's read-only state is changed
opt.autowrite = true                            -- Enable auto write (default)
opt.backspace = "indent,eol,start"              -- Activate backspace
opt.backup = false                              -- No backup file
opt.clipboard = "unnamedplus"                   -- Send yank to system clipboard
opt.cmdheight = 1                               -- More space in the neovim cmd line for displaying messages
opt.completeopt = "menu,menuone,noselect"       -- Vim popup menu behavior
opt.conceallevel = 0                            -- So that `` is visible in markdown files
opt.confirm = true                              -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                           -- Show cursor line
opt.directory= "/tmp"                           -- Directory used for storing temp files
opt.expandtab = true                            -- Convert tabs to spaces
opt.foldlevel = 99                              -- Folding
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt"                  -- Auto format options, default: tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.history = 1000                              -- keep 1000 lines of command history
opt.hlsearch = true                             -- Colorize search
opt.ignorecase = true                           -- Do case insensitive matching
opt.inccommand = "nosplit"                      -- Preview incremental substitute
opt.incsearch = true                            -- Incremental search
opt.jumpoptions = "view"
opt.laststatus = 2                              -- Always print status line
opt.linebreak = true                            -- Wrap lines at convenient points
opt.list = true                                 -- Enable list mode
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.mouse = "a"                                 -- Enable mouse
opt.number = true                               -- Print line numbers
opt.pumblend = 10                               -- Popup blend from 0 to 100
opt.pumheight = 10                              -- Pop up menu height
opt.relativenumber = true                       -- Line numbers relative to cursor
opt.ruler = true                                -- Show the cursor position all the time
opt.scrolloff = 4                               -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true                           -- Round indent
opt.shiftwidth = 4                              -- Number of spaces inserted for each indentation
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showcmd = true                              -- Show (partial) command in status line.
opt.showmatch = true                            -- Show matching brackets.
opt.showmode = false                            -- Print current mode
opt.sidescrolloff = 8                           -- Columns of context
opt.signcolumn = "yes"                          -- Draw sign column
opt.smartcase = true                            -- Do smart case matching
opt.smartindent = true                          -- Make indenting smarter again
opt.softtabstop = 4                             -- Number of spaces that a tab count
opt.spelllang = { "en" }                        -- List of spell lang
opt.splitbelow = true                           -- Horizontal splits to go below current window
opt.splitkeep = "screen"
opt.splitright = true                           -- Vertical splits to go to the right of current window
opt.swapfile = false                            -- swap files give annoying warning
opt.tabstop = 4                                 -- Insert 4 spaces for a tab
opt.termguicolors = true                        -- True color support
opt.textwidth = 0                               -- Disable max line width
opt.timeoutlen = vim.g.vscode and 1000 or 300   -- Lower than default (1000) to quickly trigger which-key
opt.ttyfast = true                              -- Indicate fast terminal conn for faster redraw
opt.undodir = undodir                           -- Undo directory
opt.undofile = true                             -- Persistent undo
opt.undolevels = 10000                          -- Maximum number of changes that can be undone
opt.undoreload = 100000                         -- Maximum number lines to save for undo on reload
opt.updatetime = 100                            -- Reduce update time for async update
opt.virtualedit = "block"                       -- Allow cursor to move where there is no text in vblock
opt.wildmode = "longest:full,full"              -- Vim bar autocomplete, alt: longest,list,full
opt.wildignore:append "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif"
opt.winminwidth = 5                             -- Minimum window width
opt.wrap = false                                -- Disable line wrap

-- vim: ts=4 sts=4 sw=4 et
