-- Neovim Editor
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Search/replace in multiple files
    -- https://github.com/MagicDuck/grug-far.nvim
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },

    -- Navigate by search labels
    -- https://github.com/folke/flash.nvim
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    -- Key binding completion
    -- https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            preset = "helix",
            plugins = {
                marks = true,           -- trigger by '
                registers = true,       -- trigger by "
                spelling = true         -- trigger by zm
            },
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>!", "<cmd>vsplit<cr>", desc = "Split Vertical" },
                    { "<leader>/", "<cmd>split<cr>", desc = "Split Horizontal" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>c", group = "code" },
                    { "<leader>d", group = "debug" },
                    { "<leader>dp", group = "profiler" },
                    { "<leader>f", group = "file/find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gh", group = "hunks" },
                    { "<leader>q", group = "quit/session" },
                    { "<leader>s", group = "search" },
                    { "<leader>t", group = "terminal" },
                    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gs", group = "surround" },
                    { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    -- better descriptions
                    { "gx", desc = "Open with system app" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            -- Leader related mappings
            --local leader = {
            --    mode = { "n" },
            --    { "<leader>c", "<cmd>bdelete<cr>", desc = "Close Buffer", nowait = true, remap = false },
            --    { "<leader>h", "<cmd>nohlsearch<cr>", desc = "No Highlight", nowait = true, remap = false },
            --    { "<leader>i", "<cmd>IndentBlanklineToggle<cr>", desc = "Indent Line", nowait = true, remap = false },
            --}
            --wk.add(leader)

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
            wk.add(terminal)

            -- Code related mappings
            --local code = {
            --    mode = { "n" },
            --    { "<leader>l?", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Doc", nowait = true, remap = false },
            --    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
            --    { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition", nowait = true, remap = false },
            --    { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declaration", nowait = true, remap = false },
            --    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", nowait = true, remap = false },
            --    { "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help", nowait = true, remap = false },
            --    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Goto Implementation", nowait = true, remap = false },
            --    { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Diagnostic Goto Next", nowait = true, remap = false },
            --    { "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Diagnostic Open", nowait = true, remap = false },
            --    { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Diagnostic Goto Prev", nowait = true, remap = false },
            --    { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References", nowait = true, remap = false },
            --    { "<leader>ls", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", desc = "Document Symbols", nowait = true, remap = false },
            --    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
            --    { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Type Definition", nowait = true, remap = false },
            --    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
            --}
            --wk.add(code)
        end,
    },

    -- Show modified lines for VCS files
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = "LazyFile",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
            },
            watch_gitdir = { interval = 1000, follow_files = true },
            attach_to_untracked = true,
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Prev Hunk")
                map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
                map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghj", gs.next_hunk, "Next Hunk")
                map("n", "<leader>ghk", gs.next_hunk, "Prev Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },
    {
        "gitsigns.nvim",
        opts = function()
            Snacks.toggle({
                name = "Git Signs",
                get = function()
                    return require("gitsigns.config").config.signcolumn
                end,
                set = function(state)
                    require("gitsigns").toggle_signs(state)
                end,
            }):map("<leader>uG")
        end,
    },

    -- List to show diag, ref, quickfix...
    -- https://github.com/folke/trouble.nvim
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        opts = {
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next Trouble/Quickfix Item",
            },
        },
    },

    -- Highlight todo comments
    -- https://github.com/folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "LazyFile",
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
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        },
    },

    -- INFO: LazyVim extra --

    -- Highlighting other uses of the word
    -- https://github.com/RRethy/vim-illuminate
    {
        'RRethy/vim-illuminate',
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            delay = 200,
            filetype_overrides = {},
            filetypes_denylist = {
                'dirbuf',
                'dirvish',
                'fugitive',
            },
            filetypes_allowlist = {},
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
            modes_denylist = {},
            modes_allowlist = {},
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            providers_regex_syntax_denylist = {},
            providers_regex_syntax_allowlist = {},
            under_cursor = true,
            min_count_to_highlight = 1,
            should_enable = function(bufnr) return true end,
            case_insensitive_regex = false,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },

    -- TEST: External plugins --

    -- Toggle terminal
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
