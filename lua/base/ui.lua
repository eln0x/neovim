-- Neovim UI
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Buffer line
    -- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
            { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        },
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) Snacks.bufdelete(n) end,
                -- stylua: ignore
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                diagnostics_indicator = function(_, _, diag)
                    local icons = LazyVim.config.icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                enforce_regular_tabs = true,
                max_name_length = 30,
                max_prefix_length = 30,
                tab_size = 21,
                separator_style = "thin",
                indicator = {
                    icon = '',
                    style = 'icon',
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                    {
                        filetype = "snacks_layout_box",
                    },
                },
                get_element_icon = function(opts)
                    return LazyVim.config.icons.ft[opts.filetype]
                end,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },

    -- Status line
    -- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = LazyVim.config.icons

            vim.o.laststatus = vim.g.lualine_laststatus

            local mode = {
                "mode",
                fmt = function(str)
                    return "-- " .. str .. " --"
                end,
            }

            local branch = {
                "branch",
                icons_enabled = true,
                icon = "",
            }

            local diff = {
                "diff",
                symbols = {
                    added = icons.git.added,
                    modified = icons.git.modified,
                    removed = icons.git.removed,
                },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            }

            local diagnostics = {
                "diagnostics",
                --sources = { "nvim_diagnostic" },
                --sections = { "warn", "error", "hint" },
                symbols = {
                    error = icons.diagnostics.Error,
                    warn = icons.diagnostics.Warn,
                    info = icons.diagnostics.Info,
                    hint = icons.diagnostics.Hint,
                },
                --colored = true,
                --update_in_insert = false,
                --always_visible = false,
            }

            local date = {
                "mode",
                fmt = function()
                    return " " .. os.date("%R")
                end,
            }

            local spaces = function()
                return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end

            local opts = {
                options = {
                    icons_enabled = true,
                    theme = "auto",                         -- "ayu_dark"
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch, diff },
                    lualine_c = {
                        LazyVim.lualine.root_dir(),
                        diagnostics,
                        { LazyVim.lualine.pretty_path() },
                    },
                    lualine_x = {
                        Snacks.profiler.status(),
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                            color = function() return { fg = Snacks.util.color("Statement") } end,
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = function() return { fg = Snacks.util.color("Constant") } end,
                        },
                        -- stylua: ignore
                        {
                            function() return "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                            color = function() return { fg = Snacks.util.color("Debug") } end,
                        },
                        -- stylua: ignore
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = function() return { fg = Snacks.util.color("Special") } end,
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                        { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
                        spaces, 'encoding', 'fileformat',
                    },
                    lualine_z = { date },
                },
                extensions = { "neo-tree", "lazy", "fzf" },
            }

            -- do not add trouble symbols if aerial is enabled
            -- And allow it to be overriden for some buffer types (see autocmds)
            if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
                local trouble = require("trouble")
                local symbols = trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
                table.insert(opts.sections.lualine_c, {
                    symbols and symbols.get,
                    cond = function()
                        return vim.b.trouble_lualine ~= false and symbols.has()
                    end,
                })
            end

            return opts
        end,
    },

    -- UI for messages, cmdline and the popupmenu.
    -- https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                -- set to disable if `vim.lsp.handlers["window/showMessage"]` has been overwritten by another plugin.
                signature = {
                    enabled = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = false,          -- popup cmdline for search
                command_palette = true,         -- position the cmdline and popupmenu together
                long_message_to_split = true,   -- long messages will be sent to a split
                inc_rename = true,              -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,          -- add a border to hover docs and signature help
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>sn", "", desc = "+noice"},
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
        config = function(_, opts)
            -- HACK: noice shows messages from before it was enabled,
            -- but this is not ideal when Lazy is installing plugins,
            -- so clear the messages in this case.
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
    },

    -- Mini icons provider
    -- https://github.com/echasnovski/mini.icons
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },

    -- UI components library
    -- https://github.com/MunifTanjim/nui.nvim
    {
        'MunifTanjim/nui.nvim',
        lazy = true,
    },

    -- Snacks UI
    -- https://github.com/folke/snacks.nvim
    {
        "snacks.nvim",
        opts = {
            dashboard = { enabled = false, preset = { keys = {} } },    -- alpha
            bigfile = { enabled = true },
            indent = { enabled = false },
            picker = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },                               -- comfortable-motion
            statuscolumn = { enabled = false },                         -- set in options.lua
            toggle = { map = LazyVim.safe_keymap_set },
            words = { enabled = false },                                -- vim-illuminate
            explorer = { enabled = true },
        },
        -- stylua: ignore
        keys = {
            { "<leader>n", function()
                if Snacks.config.picker and Snacks.config.picker.enabled then
                    Snacks.picker.notifications()
                else
                    Snacks.notifier.show_history()
                end
            end, desc = "Notification History" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>ux", function() Snacks.picker() end, desc = "Show Snacks pickers" },
            {
                "<leader>fe",
                function()
                    Snacks.explorer({ cwd = LazyVim.root() })
                end,
                desc = "Explorer Snacks (root dir)",
            },
            {
                "<leader>fE",
                function()
                    Snacks.explorer()
                end,
                desc = "Explorer Snacks (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
        },
    },

    -- INFO: LazyVim extra --

    -- Startup screen
    -- https://github.com/goolord/alpha-nvim
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
        },
        enabled = true,
        init = false,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local devicons  = require("nvim-web-devicons")
            local cdir      = vim.fn.getcwd()
            local path      = require("plenary.path")

            local function get_extension(fn)
                local match = fn:match("^.+(%..+)$")
                local ext = ""
                if match ~= nil then
                    ext = match:sub(2)
                end
                return ext
            end

            local function icon(fn)
                local ext = get_extension(fn)
                return devicons.get_icon(fn, ext, { default = true })
            end

            local function file_button(fn, sc, short_fn)
                short_fn = short_fn or fn
                local ico_txt
                local fb_hl = {}

                local ico, hl = icon(fn)
                local hl_option_type = type(devicons.highlight)
                if hl_option_type == "boolean" then
                    if hl and devicons.highlight then
                        table.insert(fb_hl, { hl, 0, 1 })
                    end
                end
                if hl_option_type == "string" then
                    table.insert(fb_hl, { devicons.highlight, 0, 1 })
                end
                ico_txt = ico .. "  "

                local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <cr>")
                local fn_start = short_fn:match(".*/")
                if fn_start ~= nil then
                    table.insert(fb_hl, { "Type", #ico_txt - 2, #fn_start + #ico_txt - 2 })
                end
                file_button_el.opts.hl = fb_hl
                return file_button_el
            end

            local default_mru_ignore = { "gitcommit" }

            local mru_opts = {
                ignore = function(_path, ext)
                    return (string.find(_path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
                end,
            }

            local function mru(start, cwd, items_number, opts)
                opts = opts or mru_opts
                items_number = items_number or 9

                local oldfiles = {}
                for _, v in pairs(vim.v.oldfiles) do
                    if #oldfiles == items_number then
                        break
                    end
                    local cwd_cond
                    if not cwd then
                        cwd_cond = true
                    else
                        cwd_cond = vim.startswith(v, cwd)
                    end
                    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
                    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
                        oldfiles[#oldfiles + 1] = v
                    end
                end

                local special_shortcuts = {}
                local target_width = 35

                local tbl = {}
                for i, fn in ipairs(oldfiles) do
                    local short_fn
                    if cwd then
                        short_fn = vim.fn.fnamemodify(fn, ":.")
                    else
                        short_fn = vim.fn.fnamemodify(fn, ":~")
                    end

                    if #short_fn > target_width then
                        short_fn = path.new(short_fn):shorten(1, { -2, -1 })
                        if #short_fn > target_width then
                            short_fn = path.new(short_fn):shorten(1, { -1 })
                        end
                    end

                    local shortcut = ""
                    if i <= #special_shortcuts then
                        shortcut = special_shortcuts[i]
                    else
                        shortcut = tostring(i + start - 1 - #special_shortcuts)
                    end

                    local file_button_el = file_button(fn, " " .. shortcut, short_fn)
                    tbl[i] = file_button_el
                end

                return {
                    type = "group",
                    val = tbl,
                    opts = {},
                }
            end

            local recents = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = "Recent files",
                        opts = {
                            hl = "Constant",
                            shrink_margin = false,
                            position = "center",
                        },
                    },
                    { type = "padding", val = 1 },
                    {
                        type = "group",
                        val = function()
                            return { mru(1, cdir, 5) }
                        end,
                        opts = { shrink_margin = false },
                    },
                },
            }

            local function header()
                local logo = {
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀ ⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀ ⠀⠀⠀⠀⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀ ⠀⠀⠀⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀ ⠀⠀⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀ ⠀⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀         ⠀ ]],
                    [[         ⠀⠀⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀         ⠀ ]],
                    [[          ⠀⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄         ⠀ ]],
                    [[         ⠀ ⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿         ⠀ ]],
                    [[         ⠀ ⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸         ⠀ ]],
                    [[         ⠀ ⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈         ⠀ ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀ ]],
                    [[         ⠀⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀           ]],
                    [[         ⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀           ]],
                    [[                             __                    ]],
                    [[      _____ _____    _______/  |_  ___________     ]],
                    [[     /     \\__  \  /  ___/\   __\/ __ \_  __ \    ]],
                    [[    |  Y Y  \/ __ \_\___ \  |  | \  ___/|  | \/    ]],
                    [[    |__|_|  (____  /____  > |__|  \___  >__|       ]],
                    [[          \/     \/     \/            \/           ]],
                }

                return {
                    type = "text",
                    val = logo,
                    opts = {
                        hl = "Operator",
                        shrink_margin = false,
                        position = "center",
                    },
                }
            end

            local function footer()
                local fortune   = require("alpha.fortune")
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local footer_text = fortune()

                table.insert(footer_text, "")
                table.insert(footer_text, "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms")

                return {
                    type = "group",
                    val = {
                        {
                            type = "text",
                            val = footer_text,
                            opts = { hl = "Constant", position = "center" },
                        },
                    },
                }
            end

            local buttons = {
                type = "group",
                val = {
                    { type = "text", val = "Quick links", opts = { hl = "Constant", position = "center" } },
                    { type = "padding", val = 1 },
                    dashboard.button("n", "  New file", "<cmd> ene <BAR> startinsert <cr>"),
                    dashboard.button("f", "  Find file", "<cmd> lua Snacks.picker.files() <cr>"),
                    dashboard.button("p", "  Find project", "<cmd> lua Snacks.picker.projects() <cr>"),
                    dashboard.button("g", "  Grep text", "<cmd> lua Snacks.picker.grep() <cr>"),
                    dashboard.button("m", "  Git Files", "<cmd> lua Snacks.picker.git_files() <cr>"),
                    dashboard.button("b", "  Browse Repo", "<cmd> lua Snacks.gitbrowse() <cr>"),
                    dashboard.button("c", "  Config", "<cmd> lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) <cr>"),
                    dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
                    dashboard.button("u", "󱐥  Sync plugins", "<cmd>Lazy sync<CR>"),
                    dashboard.button("x", "  Lazy Extras", "<cmd> LazyExtras <cr>"),
                    dashboard.button("s", "  Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                    dashboard.button("h", "  Check health", "<cmd> checkhealth <cr>"),
                    dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
                },
                position = "center",
            }

            dashboard.opts = {
                layout = {
                    { type = "padding", val = 1 }, header(),
                    { type = "padding", val = 1 }, recents,
                    { type = "padding", val = 1 }, buttons,
                    { type = "padding", val = 1 }, footer(),
                },
                opts = { margin = 5 },
            }
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)
        end,
    },

    -- Active indent guide and indent text objects. When you're browsing
    -- code, this highlights the current level of indentation, and animates
    -- the highlighting.
    -- https://github.com/echasnovski/mini.indentscope
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "LazyFile",
        opts = {
            draw = {
                delay = 100,
                priority = 2,
            },
            mappings = {
                object_scope = 'ii',
                object_scope_with_border = 'ai',
                goto_top = '[i',
                goto_bottom = ']i',
            },
            options = {
                border = 'both',
                indent_at_cursor = true,
                try_as_border = true,
            },
            symbol = '┊',
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "Trouble",
                    "alpha",
                    "dashboard",
                    "fzf",
                    "help",
                    "lazy",
                    "mason",
                    "neo-tree",
                    "notify",
                    "snacks_dashboard",
                    "snacks_notif",
                    "snacks_terminal",
                    "snacks_win",
                    "toggleterm",
                    "trouble",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "SnacksDashboardOpened",
                callback = function(data)
                    vim.b[data.buf].miniindentscope_disable = true
                end,
            })
        end,
    },

    -- TEST: External plugins --

    -- Vim Scroller
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },

    -- Lua Gui and utils
    -- https://github.com/ray-x/guihua.lua
    --{
    --    'ray-x/guihua.lua',
    --    lazy = true,
    --    opts = {
    --        maps = {
    --            close_view = '<C-e>',
    --            send_qf = '<C-q>',
    --            save = '<C-s>',
    --            jump_to_list = '<C-w>k',
    --            jump_to_preview = '<C-w>j',
    --            prev = '<C-p>',
    --            next = '<C-n>',
    --            pageup = '<C-b>',
    --            pagedown = '<C-f>',
    --            confirm = '<C-o>',
    --            split = '<C-s>',
    --            vsplit = '<C-v>',
    --            tabnew = '<C-t>',
    --        }
    --    }
    --},
}

-- vim: ts=4 sts=4 sw=4 et
