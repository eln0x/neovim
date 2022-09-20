--
-- Which key configuration
--
-- https://github.com/folke/which-key.nvim

local wkey_ok, which_key = pcall(require, "which-key")
if not wkey_ok then
    return
end

local setup = {
    plugins = {
        marks = true,                       -- shows a list of your marks on ' and `
        registers = true,                   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true,                 -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20,               -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = false,              -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,                 -- adds help for motions
            text_objects = true,            -- help for text objects triggered after entering an operator
            windows = true,                 -- default bindings on <c-w>
            nav = true,                     -- misc bindings to work with windows
            z = true,                       -- bindings for folds, spelling and others prefixed with z
            g = true,                       -- bindings for prefixed with g
        },
    },
    key_labels = {},
    icons = {
        breadcrumb = "»",                   -- symbol used in the command line area that shows your active key combo
        separator = "➜",                    -- symbol used between a key and it's label
        group = "+",                        -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>",              -- binding to scroll down inside the popup
        scroll_up = "<c-u>",                -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded",                 -- none, single, double, shadow
        position = "bottom",                -- bottom, top
        margin = { 1, 0, 1, 0 },            -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 },           -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },     -- min and max height of the columns
        width = { min = 20, max = 50 },     -- min and max width of the columns
        spacing = 5,                        -- spacing between columns
        align = "center",                     -- align columns left, center or right
    },
    ignore_missing = true,                  -- enable this to hide mappings for which you didn't specify a label
    show_help = true,                       -- show help message on the command line when the popup is visible
    triggers = "auto",                      -- automatically setup triggers
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
}
which_key.setup(setup)

local opts = {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
}

local mappings = {
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Buffers" },
    c = { "<cmd>bdelete<CR>", "Close Buffer" },
    f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",  "files" },
    G = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    i = { "<cmd>IndentBlanklineToggle<cr>", "Indent Line" },
    k = { "<cmd>WhichKey<cr>", "Which Key" },
    P = { "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Projects" },
    q = { "<cmd>q<CR>", "Quit" },
    w = { "<cmd>w<CR>", "Save" },
    x = { "<cmd>source %<CR>", "Reload Conf" },
    ["!"] = { "<cmd>vsplit<CR>", "Split Vertical" },
    ["/"] = { "<cmd>split<CR>", "Split Horizontal" },
    g = {
        name = "Git",
        g = { "<cmd>lua GitToggle()<CR>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",  "Undo Stage Hunk" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    },
    l = {
        name = "Lsp",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
        k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    },
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    s = {
        name = "Search",
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        n = { "<cmd>Telescope notify<cr>", "Notifications" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        s = { "<cmd>lua require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown{previewer = false})<cr>",  "Colorscheme" },
    },
    t = {
        name = "Terminal",
        n = { "<cmd>lua NodeToggle()<cr>", "Node" },
        u = { "<cmd>lua NcduToggle()<cr>", "Ncdu" },
        t = { "<cmd>lua HtopToggle()<cr>", "Htop" },
        p = { "<cmd>lua PythonToggle()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },
}

which_key.register(mappings, opts)
