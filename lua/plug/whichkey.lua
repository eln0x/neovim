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
        marks = false,                      -- shows a list of your marks on ' and `
        registers = false,                   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
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
            g = false,                       -- bindings for prefixed with g
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
        align = "center",                   -- align columns left, center or right
    },
    ignore_missing = true,                  -- enable this to hide mappings for which you didn't specify a label
    show_help = true,                       -- show help message on the command line when the popup is visible
    triggers = "auto",                      -- automatically setup triggers
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " },
}
which_key.setup(setup)

-- Leader related mappings
local lead_opts = {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
}

local lead_mappings = {
    ["!"] = { "<cmd>vsplit<cr>", "Split Vertical" },
    ["/"] = { "<cmd>split<cr>", "Split Horizontal" },
    c = { "<cmd>bdelete<cr>", "Close Buffer" },
    h = { "<cmd>nohlsearch<cr>", "No Highlight" },
    i = { "<cmd>IndentBlanklineToggle<cr>", "Indent Line" },
    q = { "<cmd>q<cr>", "Quit Neovim" },
    w = { "<cmd>w<cr>", "Save Buffer" },
    x = { "<cmd>source %<cr>", "Reload Conf" },


}

which_key.register(lead_mappings, lead_opts)

-- Telescope related mappings
local f_map = {
    b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
    c = { "<cmd>Telescope commands theme=ivy<cr>", "Commands" },
    f = { "<cmd>Telescope find_files theme=ivy<cr>",  "Files" },
    g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep" },
    k = { "<cmd>Telescope keymaps theme=ivy<cr>", "Keymaps" },
    m = { "<cmd>Telescope man_pages theme=ivy<cr>", "Man Pages" },
    n = { "<cmd>Telescope notify theme=ivy<cr>", "Notifications" },
    o = { "<cmd>Telescope git_status theme=ivy<cr>", "Changed" },
    s = { "<cmd>lua require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown{previewer = false})<cr>",  "Colorschemes" },
    p = { "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Projects" },
}
which_key.register( f_map, {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>f",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
})

-- Lsp related mappings
local l_map = {
    ["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Doc" },
    ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    ["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
    ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
    ["f"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    ["h"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
    ["n"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Diagnostic Goto Next" },
    ["o"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostic Open" },
    ["p"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Diagnostic Goto Prev" },
    ["r"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
    ["s"] = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document Symbols" },
    ["S"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    ["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
    ["w"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
}
which_key.register(l_map, {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>l",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
})

-- Git related mappings
local g_map = {
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
}
which_key.register(g_map, {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>g",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
})

-- Terminal related mappings
local t_map = {
    g = { "<cmd>lua GitToggle()<cr>", "Lazygit" },
    n = { "<cmd>lua NodeToggle()<cr>", "Node" },
    u = { "<cmd>lua NcduToggle()<cr>", "Ncdu" },
    t = { "<cmd>lua HtopToggle()<cr>", "Htop" },
    p = { "<cmd>lua PythonToggle()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
}
which_key.register(t_map, {
    mode = "n",                             -- NORMAL mode
    prefix = "<leader>t",
    buffer = nil,                           -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,                          -- use `silent` when creating keymaps
    noremap = true,                         -- use `noremap` when creating keymaps
    nowait = true,                          -- use `nowait` when creating keymaps
})
