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
        marks = false,
        registers = false,
        spelling = true,
        presets = {
            operators = false,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = false,
        },
    },
    layout = {
        spacing = 5,
        align = "center",
    },
}
which_key.setup(setup)

-- Default mappings and groups
local defaults = {
    mode = { "n", "v" },
    { "<leader>!", "<cmd>vsplit<cr>", desc = "Split Vertical" },
    { "<leader>/", "<cmd>split<cr>", desc = "Split Horizontal" },
    { "<leader><tab>", group = "tabs" },
    --{ "<leader>b", group = "buffer" },
    { "<leader>l", group = "code" },
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>q", group = "quit/session" },
    --{ "<leader>s", group = "search" },
    --{ "<leader>sn", group = "noice" },
    { "<leader>t", group = "terminal" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "windows" },
    --{ "<leader>x", group = "diagnostics/quickfix" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
    { "gs", group = "surround" },
    { "z", group = "fold" },
}
which_key.add(defaults)

-- Leader related mappings
local leader = {
    mode = { "n" },
    { "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find Buffer", nowait = true, remap = false },
    { "<leader>c", "<cmd>bdelete<cr>", desc = "Close Buffer", nowait = true, remap = false },
    { "<leader>h", "<cmd>nohlsearch<cr>", desc = "No Highlight", nowait = true, remap = false },
    --{ "<leader>i", "<cmd>IndentBlanklineToggle<cr>", desc = "Indent Line", nowait = true, remap = false },
    { "<leader>p", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find Projects", nowait = true, remap = false },
    { "<leader>s", "<cmd>w<cr>", desc = "Save Buffer", nowait = true, remap = false },
}
which_key.add(leader)


-- Terminal related mappings
local terminal = {
    mode = { "n" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
    { "<leader>tg", "<cmd>lua GitToggle()<cr>", desc = "Lazygit", nowait = true, remap = false },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
    { "<leader>tn", "<cmd>lua NodeToggle()<cr>", desc = "Node", nowait = true, remap = false },
    { "<leader>tp", "<cmd>lua PythonToggle()<cr>", desc = "Python", nowait = true, remap = false },
    { "<leader>tt", "<cmd>lua HtopToggle()<cr>", desc = "Htop", nowait = true, remap = false },
    { "<leader>tu", "<cmd>lua NcduToggle()<cr>", desc = "Ncdu", nowait = true, remap = false },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", nowait = true, remap = false },
}
which_key.add(terminal)

-- Finder related mappings
local finder = {
    mode = { "n" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", nowait = true, remap = false },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files", nowait = true, remap = false },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep", nowait = true, remap = false },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
    { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications", nowait = true, remap = false },
    { "<leader>fo", "<cmd>Telescope git_status<cr>", desc = "Changed", nowait = true, remap = false },
    { "<leader>fs", "<cmd>lua require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Colorschemes", nowait = true, remap = false },
    { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Projects", nowait = true, remap = false },
}
which_key.add(finder)

-- Git related mappings
local git = {
    mode = { "n" },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
}
which_key.add(git)

-- Code related mappings
local code = {
    mode = { "n" },
    { "<leader>l?", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Doc", nowait = true, remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
    { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition", nowait = true, remap = false },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declaration", nowait = true, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", nowait = true, remap = false },
    { "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help", nowait = true, remap = false },
    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Goto Implementation", nowait = true, remap = false },
    { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Diagnostic Goto Next", nowait = true, remap = false },
    { "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Diagnostic Open", nowait = true, remap = false },
    { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Diagnostic Goto Prev", nowait = true, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References", nowait = true, remap = false },
    { "<leader>ls", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", desc = "Document Symbols", nowait = true, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
    { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Type Definition", nowait = true, remap = false },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
}
which_key.add(code)

-- vim: ts=4 sts=4 sw=4 et
