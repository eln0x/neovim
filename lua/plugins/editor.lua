-- Neovim Editor
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🔍 Multi-file search/replace
    -- https://github.com/MagicDuck/grug-far.nvim
    {
        "MagicDuck/grug-far.nvim",
        enabled = true,
        opts = { headerMaxWidth = 80 },
    },

    -- ⚡ Jump to any position by labels
    -- https://github.com/folke/flash.nvim
    {
        "folke/flash.nvim",
        enabled = true,
        opts = {},
    },

    -- ⌨️ Keybinding hints
    -- https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        enabled = true,
        opts = {
            preset = "helix",
            plugins = {
                marks = true,           -- trigger by '
                registers = true,       -- trigger by "
                spelling = true         -- trigger by zm
            },
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>t", group = "terminal" },
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            --local terminal = {
            --    mode = { "n" },
            --    { "<leader>tg", "<cmd>lua GitToggle()<cr>", desc = "Lazygit", nowait = true, remap = false },
            --    { "<leader>tn", "<cmd>lua NodeToggle()<cr>", desc = "Node", nowait = true, remap = false },
            --    { "<leader>tp", "<cmd>lua PythonToggle()<cr>", desc = "Python", nowait = true, remap = false },
            --    { "<leader>tu", "<cmd>lua NcduToggle()<cr>", desc = "Ncdu", nowait = true, remap = false },
            --}
            --wk.add(terminal)
        end,
    },

    -- 🌿 Git signs for buffers
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            watch_gitdir = { interval = 1000, follow_files = true },
            attach_to_untracked = true,
        },
    },

    -- 📝 Diagnostics/refs list
    -- https://github.com/folke/trouble.nvim
    {
        "folke/trouble.nvim",
        enabled = true,
        opts = {
            use_diagnostic_signs = true,
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
    },

    -- 🛠️ Highlight TODO/FIX comments
    -- https://github.com/folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        enabled = true,
        opts = {
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            highlight = {
                multiline = true,
                multiline_pattern = "^.",
                multiline_context = 10,
                before = "",
                keyword = "wide",
                after = "fg",
                pattern = [[.*<(KEYWORDS)\s*:]],
                comments_only = true,
                max_line_len = 400,
                exclude = {},
            },
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
