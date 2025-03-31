-- Editor
-- stylua: ignore
--if true then return {} end

return {
    -- Key binding completion
    -- https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                marks = false,
                registers = false,
                spelling = true
            },
            layout = {
                spacing = 5,
                align = "center",
            },
            defaults = {
                mode = { "n", "v" },
                { "<leader>!", "<cmd>vsplit<cr>", desc = "Split Vertical" },
                { "<leader>/", "<cmd>split<cr>", desc = "Split Horizontal" },
                { "<leader><tab>", group = "tabs" },
                { "<leader>b", group = "buffer" },
                { "<leader>l", group = "code", desc = "Coding" },
                { "<leader>f", group = "file/find", desc = "Find" },
                { "<leader>g", group = "git", desc = "Git" },
                { "<leader>gh", group = "hunks" },
                { "<leader>q", group = "quit/session" },
                { "<leader>s", group = "search" },
                { "<leader>sn", group = "noice" },
                { "<leader>u", group = "ui" },
                { "<leader>w", group = "windows" },
                { "<leader>x", group = "diagnostics/quickfix" },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
                { "gs", group = "surround" },
                { "z", group = "fold" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add(opts.defaults)

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
            wk.add(finder)

            -- Git related mappings
            local git = {
                mode = { "n" },
                { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
                { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
                { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
                { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
            }
            wk.add(git)

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
            wk.add(code)

        end,
    },

    -- File explorer
    -- https://github.com/nvim-tree/nvim-tree.lua
    {
        'nvim-tree/nvim-tree.lua',
        opts = function()
            local vim = vim

            -- disable netrw
            vim.g.loaded = 1
            vim.g.loaded_netrwPlugin = 1
            local HEIGHT_RATIO = 0.7 -- You can change this
            local WIDTH_RATIO = 0.5  -- You can change this too
            return {
                disable_netrw = true,
                hijack_netrw = true,
                respect_buf_cwd = true,
                sync_root_with_cwd = true,
                filters = {
                    dotfiles = true,
                    custom = {},
                    exclude = {},
                },
                renderer = {
                    root_folder_modifier = ":t",
                    group_empty = true,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                view = {
                    relativenumber = true,
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                            - vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function()
                        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                    end,
                },
            }
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    -- Fuzzy finder
    -- https://github.com/nvim-telescope/telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = vim.fn.executable("make") == 1 and "make"
                    or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
            },
        },
        opts = function()
            local actions = require("telescope.actions")

            local notify_ok, _n = pcall(require, 'notify')
            if notify_ok then
                require("telescope").load_extension("notify")
            end

            local fzf_ok, _n = pcall(require, 'fzf_lib')
            if fzf_ok then
                require("telescope").load_extension("fzf")
            end

            local proj_ok, _n = pcall(require, 'project_nvim')
            if proj_ok then
                require("telescope").load_extension("projects")
            end

            return {
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = " ",
                    path_display = { "smart" },
                    file_ignore_patterns = { ".git/", "node_modules" },
                    borderchars = {
                        prompt = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
                        preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
                        results = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
                    },
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "bottom",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    mappings = {
                        i = {
                            ["<C-_>"] = actions.which_key,
                        },
                        n = {
                            ["?"] = actions.which_key,
                        },
                    },
                },
            }
        end,
    },

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

    -- Highlight todo comments
    -- https://github.com/folke/todo-comments.nvim
    {
        'folke/todo-comments.nvim',
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            signs = true,
            sign_priority = 8,
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
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = { fg = "NONE", bg = "BOLD" },
            merge_keywords = true,
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
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            },
        },
        config = function(_, opts)
            require("todo-comments").setup(opts)
        end,
    },

    -- Show modified lines for VCS files
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = { interval = 1000, follow_files = true },
            attach_to_untracked = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                ignore_whitespace = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = {
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            --on_attach = function(buffer)
            --    local gs = package.loaded.gitsigns

            --    local function map(mode, l, r, desc)
            --        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            --    end

            --    -- stylua: ignore start
            --    map("n", "]h", gs.next_hunk, "Next Hunk")
            --    map("n", "[h", gs.prev_hunk, "Prev Hunk")
            --    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            --    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            --    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
            --    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
            --    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
            --    map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
            --    map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
            --    map("n", "<leader>ghd", gs.diffthis, "Diff This")
            --    map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
            --    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            --end,
        },
    },

    -- Search and replace panel
    -- https://github.com/nvim-pack/nvim-spectre
    {
        'nvim-pack/nvim-spectre',
        build = false,
        cmd = "Spectre",
        opts = {
            color_devicons = true,
            open_cmd = "noswapfile vnew",
            live_update = false,
            lnum_for_results = true,
            line_sep_start = '┌-----------------------------------------',
            result_padding = '¦  ',
            line_sep       = '└-----------------------------------------',
            highlight = {
                ui = "String",
                search = "DiffChange",
                replace = "DiffDelete"
            },
        },
    },

    -- Navigate by search labels
    -- https://github.com/folke/flash.nvim
    {
        'folke/flash.nvim',
        event = "VeryLazy",
        opts = {},
    },

    -- Code outline and nav helper
    -- https://github.com/stevearc/aerial.nvim
    {
        'stevearc/aerial.nvim',
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
            show_guides = true,
            layout = {
                max_width = { 40, 0.2 },
                width = 40,
                min_width = 20,
                default_direction = "prefer_right",
                placement = "edge",
                resize_to_content = false,
                win_opts = {
                    winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
                    signcolumn = "yes",
                    statuscolumn = " ",
                },
            },
            ignore = {
                unlisted_buffers = true,
            },
            open_automatic = false,
            lsp = {
                diagnostics_trigger_update = true,
            },
            -- stylua: ignore
            guides = {
                mid_item   = "├╴",
                last_item  = "└╴",
                nested_top = "│ ",
                whitespace = "  ",
            },
        }
    },

    -- List to show diag, ref, quickfix...
    -- https://github.com/folke/trouble.nvim
    {
        'folke/trouble.nvim',
        opts = {},
        config = function(_, opts)
            require("trouble").setup(opts)
        end,
    },

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
            function GitToggle()
                git:toggle()
            end

            local node = Terminal:new({ cmd = "node", hidden = true })
            function NodeToggle()
                node:toggle()
            end

            local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
            function NcduToggle()
                ncdu:toggle()
            end

            local htop = Terminal:new({ cmd = "htop", hidden = true })
            function HtopToggle()
                htop:toggle()
            end

            local python = Terminal:new({ cmd = "python", hidden = true })
            function PythonToggle()
                python:toggle()
            end
        end,
    },

    -- Vim Scroller
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },

}

-- vim: ts=4 sts=4 sw=4 et
