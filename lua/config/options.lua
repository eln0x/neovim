-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Behavior
vim.g.autoformat = false                        -- Disable LazyVim auto format

-- Options
local opt = vim.opt
local undodir = os.getenv( "HOME" ) .. '/.cache/nvim/undo'

opt.autoread = true                             -- Update when a file's read-only state is changed
opt.conceallevel = 0                            -- So that `` is visible in markdown files
opt.directory= "/tmp"                           -- Directory used for storing temp files
opt.foldmethod = "indent"
opt.history = 1000                              -- keep 1000 lines of command history
opt.hlsearch = true                             -- Colorize search
opt.incsearch = true                            -- Incremental search
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.ruler = true                                -- Show the cursor position all the time
opt.shiftwidth = 4                              -- Number of spaces inserted for each indentation
opt.showcmd = true                              -- Show (partial) command in status line.
opt.showmatch = true                            -- Show matching brackets.
opt.softtabstop = 4                             -- Number of spaces that a tab count
opt.swapfile = false                            -- swap files give annoying warning
opt.tabstop = 4                                 -- Insert 4 spaces for a tab
opt.textwidth = 0                               -- Disable max line width
opt.ttyfast = true                              -- Indicate fast terminal conn for faster redraw
opt.undodir = undodir                           -- Undo directory
opt.undoreload = 100000                         -- Maximum number lines to save for undo on reload
opt.updatetime = 100                            -- Reduce update time for async update
opt.wildignore:append "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif"

-- vim: ts=4 sts=4 sw=4 et
