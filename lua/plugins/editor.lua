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
            wk.add(terminal)
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

    -- 🖥️ Toggle terminal integration
    -- https://github.com/akinsho/toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = { border = "curved" },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            function _G.set_terminal_keymaps()
                local opts = {noremap = true}
                vim.api.nvim_buf_set_keymap(0, 't', '<leader><Up>', [[<cmd>wincmd k<cr>]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', '<leader><Left>', [[<cmd>wincmd h<cr>]], opts)
            end

            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

            local Terminal = require("toggleterm.terminal").Terminal

            local git = Terminal:new({ cmd = "lazygit", hidden = true })
            function GitToggle() git:toggle() end

            local node = Terminal:new({ cmd = "node", hidden = true })
            function NodeToggle() node:toggle() end

            local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
            function NcduToggle() ncdu:toggle() end

            local htop = Terminal:new({ cmd = "htop", hidden = true })
            function HtopToggle() htop:toggle() end

            local python = Terminal:new({ cmd = "python", hidden = true })
            function PythonToggle() python:toggle() end
        end,
    },
}

-- vim: ts=4 sts=4 sw=4 et
