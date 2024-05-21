-- Editor
-- stylua: ignore
--if true then return {} end

return {
    -- Key binding completion
    -- https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        opts = {
            plugins = {
                marks = false,
                registers = false,
                spelling = true
            },
            window = {
                border = "rounded",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 2, 2, 2, 2 },
                winblend = 0,
            },
            layout = {
                spacing = 5,
                align = "center",
            },
            ignore_missing = true,
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gs"] = { name = "+surround" },
                ["z"] = { name = "+fold" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>sn"] = { name = "+noice" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)

            ---- Leader related mappings
            --local lead_mappings = {
            --    ["!"] = { "<cmd>vsplit<cr>", "Split Vertical" },
            --    ["/"] = { "<cmd>split<cr>", "Split Horizontal" },
            --    c = { "<cmd>bdelete<cr>", "Close Buffer" },
            --    h = { "<cmd>nohlsearch<cr>", "No Highlight" },
            --    i = { "<cmd>IndentBlanklineToggle<cr>", "Indent Line" },
            --    q = { "<cmd>q<cr>", "Quit Neovim" },
            --    w = { "<cmd>w<cr>", "Save Buffer" },
            --    x = { "<cmd>source %<cr>", "Reload Conf" },
            --}
            --wk.register(lead_mappings, {
            --    moe = "n",
            --    prefix = "<leader>",
            --    buffer = nil,
            --    silent = true,
            --    noremap = true,
            --    nowait = true,
            --})

            ---- Telescope related mappings
            --local f_map = {
            --    b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
            --    c = { "<cmd>Telescope commands theme=ivy<cr>", "Commands" },
            --    f = { "<cmd>Telescope find_files theme=ivy<cr>",  "Files" },
            --    g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep" },
            --    k = { "<cmd>Telescope keymaps theme=ivy<cr>", "Keymaps" },
            --    m = { "<cmd>Telescope man_pages theme=ivy<cr>", "Man Pages" },
            --    n = { "<cmd>Telescope notify theme=ivy<cr>", "Notifications" },
            --    o = { "<cmd>Telescope git_status theme=ivy<cr>", "Changed" },
            --    s = { "<cmd>lua require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown{previewer = false})<cr>",  "Colorschemes" },
            --    p = { "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Projects" },
            --}
            --wk.register( f_map, {
            --    mode = "n",
            --    prefix = "<leader>f",
            --    buffer = nil,
            --    silent = true,
            --    noremap = true,
            --    nowait = true,
            --})

            ---- Lsp related mappings
            --local l_map = {
            --    ["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Doc" },
            --    ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            --    ["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
            --    ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
            --    ["f"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
            --    ["h"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
            --    ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
            --    ["n"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Diagnostic Goto Next" },
            --    ["o"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostic Open" },
            --    ["p"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Diagnostic Goto Prev" },
            --    ["r"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
            --    ["s"] = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document Symbols" },
            --    ["S"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
            --    ["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
            --    ["w"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
            --}
            --wk.register(l_map, {
            --    mode = "n",
            --    prefix = "<leader>l",
            --    buffer = nil,
            --    silent = true,
            --    noremap = true,
            --    nowait = true,
            --})

            ---- Git related mappings
            --local g_map = {
            --    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            --    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            --    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            --    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            --}
            --wk.register(g_map, {
            --    mode = "n",
            --    prefix = "<leader>g",
            --    buffer = nil,
            --    silent = true,
            --    noremap = true,
            --    nowait = true,
            --})

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
            wk.register(t_map, {
                mode = "n",
                prefix = "<leader>t",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            })
        end,
    },

    -- File explorer
    -- https://github.com/nvim-tree/nvim-tree.lua
    {
        'nvim-tree/nvim-tree.lua',
        opts = function()
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
        version = false, -- telescope did only one release, so use HEAD for now
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
    },

    -- Show modified lines for VCS files
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
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
            current_line_blame_formatter_opts = {
                relative_time = false,
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
            yadm = {
                enable = false,
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
        opts = {},
    },

    -- Tags browser
    -- https://github.com/preservim/tagbar
    {
        'preservim/tagbar',
        opts = {},
        config = function(_, opts)
            vim.cmd [[
                let g:tagbar_map_showproto = '\'
                let g:tagbar_sort = 0
                let g:tagbar_compact = 1
                let g:tagbar_autoshowtag = 1
                let g:tagbar_previewwin_pos = "aboveleft"
                let g:tagbar_autopreview = 0
                let g:tagbar_singleclick = 1
                let g:tagbar_autofocus = 1
            ]]
        end,
    },

    -- Tags management
    -- https://github.com/ludovicchabant/vim-gutentags
    {
        'ludovicchabant/vim-gutentags',
        opts = {},
        config = function(_, opts)
            vim.cmd [[
                let g:gutentags_project_root = ['.project']
                let g:gutentags_cache_dir = '~/.cache/nvim/tags'
                let g:gutentags_exclude_project_root = []
                let g:gutentags_exclude_filetypes = []
                let g:gutentags_add_default_project_roots = 0
                let g:gutentags_resolve_symlinks = 1
                let g:gutentags_modules = ['ctags', 'cscope']
                let g:gutentags_ctags_extra_args = ['--fields=+niaSszt --extra=+q --python-kinds=-vi --tag-relative=yes']
                let g:gutentags_file_list_command = 'find . -type f -regextype posix-egrep -regex ".*\.(py|go|pl|sh)$" -not -path "*/\.*" -follow'
                let g:gutentags_enabled_user_func = 'GutentagsEnableFunc'
            ]]

            vim.cmd [[
                function! GutentagsEnableFunc(path)
                    let file_ext = fnamemodify(a:path, ':e')
                    let allowed_file_ext = ['py', 'go', 'pl', 'sh']
                    if (index(allowed_file_ext, file_ext) >= 0) | return 1 | else | return 0 | endif
                endfunction
            ]]
        end,
    },

    -- Code outline and nav helper
    -- https://github.com/stevearc/aerial.nvim
    {
        'stevearc/aerial.nvim',
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