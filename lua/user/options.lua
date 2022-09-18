--
-- NeoVim common
--
local opt = vim.opt
local undodir = os.getenv( "HOME" ) .. '/.cache/nvim/undo'

local options = {
    mouse = "a",                                 -- Enable mouse
    compatible = false,                          -- Set compatibility to Vim only.
    magic = true,                                -- Magic pattern
    signcolumn = "auto",                         -- Draw sign column
    number = true,                               -- Print line numbers
    relativenumber = true,                       -- Line numbers relative to cursor
    cursorline = true,                           -- Show cursor line
    clipboard = "unnamedplus",                   -- Send yank to system clipboard
    keymodel = "startsel",                       -- Shift+arrow selection
    ruler = true,                                -- Show the cursor position all the time
    showmode = false,                            -- Print current mode
    showcmd = true,                              -- Show (partial) command in status line.
    showmatch = true,                            -- Show matching brackets.
    ttyfast = true,                              -- Indicate fast terminal conn for faster redraw
    ignorecase = true,                           -- Do case insensitive matching
    smartcase = true,                            -- Do smart case matching
    incsearch = true,                            -- Incremental search
    hlsearch = true,                             -- Colorize search
    autowrite = true,                            -- Automatically save before :next and :make
    autoread = true,                             -- Update when a file's read-only state is changed
    hidden = true,                               -- Hide buffers when they are abandoned
    backup = false,                              -- No backup file
    undodir = undodir,                           -- Undo directory
    undofile = true,                             -- Persistent undo
    undolevels = 10000,                          -- Maximum number of changes that can be undone
    undoreload = 100000,                         -- Maximum number lines to save for undo on reload
    history = 1000,                              -- keep 1000 lines of command history
    foldmethod = "syntax",                       -- Use syntax based folding method
    backspace = "indent,eol,start",              -- Activate backspace
    laststatus = 2,                              -- Always print status line
    wildmenu = true,                             -- Activate wildmenu
    wildmode = "longest:full,full",              -- Vim bar autocomplete, alt: longest,list,full
    completeopt = "menu,preview",                -- Vim popup menu behavior
    matchpairs = "(:),{:},[:],<:>",              -- Highlight pairs of brackets, use '%' char to jump.
    swapfile = false,                            -- swap files give annoying warning
    directory= "/tmp",                           -- Directory used for storing temp files
    updatetime = 100,                            -- Reduce update time for async update
    fileencoding = "utf-8",                      -- Encoding written to a file
    smartindent = true,                          -- Make indenting smarter again
    tabstop = 4,                                 -- Insert 4 spaces for a tab
    shiftwidth = 4,                              -- Number of spaces inserted for each indentation
    softtabstop = 4,                             -- Number of spaces that a tab count
    textwidth = 0,                               -- Disable max line width
    expandtab = true,                            -- Convert tabs to spaces
    pumheight = 10,                              -- Pop up menu height
    splitbelow = true,                           -- Horizontal splits to go below current window
    splitright = true,                           -- Vertical splits to go to the right of current window
    list = true,                                 -- Enable list mode
    cmdheight = 1,                               -- more space in the neovim command line for displaying messages
    conceallevel = 0,                            -- so that `` is visible in markdown files
}

opt.shortmess:append "c"                         -- Don't give ins-completion-menu messages

for k, v in pairs(options) do
    vim.opt[k] = v
end

opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.wildignore:append "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.pdf,*.jpg,*.png,*.gif"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
