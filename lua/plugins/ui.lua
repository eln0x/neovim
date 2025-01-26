-- Neovim UI
-- stylua: ignore
--if true then return {} end

local vim = vim

return {
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
                    [[            .__                                    ]],
                    [[            |  | _____  ___________.__.            ]],
                    [[            |  | \__  \ \___   <   |  |            ]],
                    [[            |  |__/ __ \_/    / \___  |            ]],
                    [[            |____(____  /_____ \/ ____|            ]],
                    [[                      \/      \/\/                 ]],
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
                    dashboard.button("f", "  Find file", "<cmd> Telescope find_files <cr>"),
                    dashboard.button("p", "  Find project", "<cmd> Telescope projects <cr>"),
                    dashboard.button("g", "  Find text", "<cmd> Telescope live_grep <cr>"),
                    dashboard.button("m", "  Find modified file", "<cmd> Telescope git_status <cr>"),
                    dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
                    dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy sync<CR>"),
                    dashboard.button("s", "  Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                    dashboard.button("h", "  Check health", "<cmd> checkhealth <cr>"),
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

    -- Buffer line
    -- https://github.com/akinsho/bufferline.nvim
    {
        'akinsho/bufferline.nvim',
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
                always_show_bufferline = true,
                enforce_regular_tabs = true,
                numbers = "none",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                buffer_close_icon = '',
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 30,
                max_prefix_length = 30,
                tab_size = 21,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "",
                        padding = 1
                    },
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                persist_buffer_sort = true,
                separator_style = "thin",
                indicator = {
                    icon = '',
                    style = 'icon',
                },
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
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

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
                    added = " "  ,
                    modified = " ",
                    removed = " "  ,
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
                sources = { "nvim_diagnostic" },
                sections = { "warn", "error", "hint" },
                symbols = {
                    error = " "  ,
                    warn = " "  ,
                    hint = " "  ,
                    info = " "  ,
                },
                colored = true,
                update_in_insert = false,
                always_visible = false,
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
                    theme = "ayu_dark",
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch, diff },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 1
                        },
                        diagnostics,
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        },
                        -- stylua: ignore
                        {
                            function() return "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        },
                        -- stylua: ignore
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                        },
                    },
                    lualine_y = {
                        {
                            "progress",
                            separator = " ",
                            padding = { left = 1, right = 0 }
                        },
                        {
                            "location",
                            padding = { left = 0, right = 1 }
                        },
                        {
                            "filetype",
                            icon_only = false,
                            separator = "",
                            padding = { left = 1, right = 0 }
                        },
                        spaces, 'encoding', 'fileformat',
                    },
                    lualine_z = { date },
                },
                extensions = { "neo-tree", "lazy" },
            }

            -- do not add trouble symbols if aerial is enabled
            if vim.g.trouble_lualine then
                local trouble = require("trouble")
                local symbols = trouble.statusline
                and trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
                table.insert(opts.sections.lualine_c, {
                    symbols and symbols.get,
                    cond = symbols and symbols.has,
                })
            end

            return opts
        end,
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
    },

    -- Show indentation when no tab
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            indent = {
                char = "┊",
                tab_char = "│",
            },
            exclude = {
                buftypes = {
                    "terminal",
                    "nofile"
                },
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "NvimTree",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "packer",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
            whitespace = {
                remove_blankline_trail = false,
            },
            scope = { enabled = true },
        },
        init = function()
            local hooks = require "ibl.hooks"
            hooks.register(
                hooks.type.WHITESPACE,
                hooks.builtin.hide_first_space_indent_level
            )
            hooks.register(
                hooks.type.WHITESPACE,
                hooks.builtin.hide_first_tab_indent_level
            )
        end,
        main = "ibl",
    },

    -- Visualize and work with indent scope
    -- https://github.com/echasnovski/mini.indentscope
    {
        'echasnovski/mini.indentscope',
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "packer",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    -- Notification manager
    -- https://github.com/rcarriga/nvim-notify
    {
        'rcarriga/nvim-notify',
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss All Notifications",
            },
        },
        opts = {
            stages = 'slide',
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
        },
        init = function()
            local noice_ok, notify = pcall(require, "noice")
            if not noice_ok then
                vim.notify = require("notify")
            end

            -- Lsp notification customization
            vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local level = ({
                    'ERROR',
                    'WARN',
                    'INFO',
                    'DEBUG',
                })[result.type]
                notify(
                    { result.message },
                    level,
                    {
                        title = '[lsp] | ' .. client.name,
                        keep = function()
                            return level == 'ERROR' or level == 'WARN'
                        end,
                    }
                )
            end

            vim.lsp.buf.rename = function()
                local position_params = vim.lsp.util.make_position_params()
                position_params.oldName = vim.fn.expand("<cword>")
                position_params.newName = vim.fn.input("Rename To> ", position_params.oldName)
                vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, result, ...)
                    if not result or not result.changes then
                        notify(
                            string.format('could not perform rename'),
                            'error',
                            {
                                title = string.format(
                                    '[lsp] rename: %s -> %s',
                                    position_params.oldName,
                                    position_params.newName
                                ),
                                timeout = 2500
                            })
                        return
                    end

                    vim.lsp.handlers["textDocument/rename"](err, result, ...)
                    local notification, entries = '', {}
                    local num_files, num_updates = 0, 0
                    for uri, edits in pairs(result.changes) do
                        num_files = num_files + 1
                        local bufnr = vim.uri_to_bufnr(uri)
                        for _, edit in ipairs(edits) do
                            local start_line = edit.range.start.line + 1
                            local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]
                            num_updates = num_updates + 1
                            table.insert(entries, {
                                bufnr = bufnr,
                                lnum = start_line,
                                col = edit.range.start.character + 1,
                                text = line
                            })
                        end
                        local short_uri = string.sub(vim.uri_to_fname(uri), #vim.fn.getcwd() + 2)
                        notification = notification .. string.format('made %d change(s) in %s', #edits, short_uri)
                    end
                    notify(
                        notification,
                        'info',
                        {
                            title = string.format(
                                '[lsp] rename: %s -> %s',
                                position_params.oldName,
                                position_params.newName
                            ),
                            timeout = 2000
                        })
                end)
            end
        end,
    },

    -- UI for messages, cmdline and the popupmenu.
    -- https://github.com/folke/noice.nvim
    {
        'folke/noice.nvim',
        event = "VeryLazy",
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
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
                lsp_doc_border = false,         -- add a border to hover docs and signature help
            },
        },
    },

    -- UI improvements
    -- https://github.com/stevearc/dressing.nvim
    {
        'stevearc/dressing.nvim',
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- UI components
    -- https://github.com/MunifTanjim/nui.nvim
    {
        'MunifTanjim/nui.nvim',
        lazy = true,
    },

    -- Lua Gui and utils
    -- https://github.com/ray-x/guihua.lua
    {
        'ray-x/guihua.lua',
        lazy = true,
        opts = {
            maps = {
                close_view = '<C-e>',
                send_qf = '<C-q>',
                save = '<C-s>',
                jump_to_list = '<C-w>k',
                jump_to_preview = '<C-w>j',
                prev = '<C-p>',
                next = '<C-n>',
                pageup = '<C-b>',
                pagedown = '<C-f>',
                confirm = '<C-o>',
                split = '<C-s>',
                vsplit = '<C-v>',
                tabnew = '<C-t>',
            }
        }
    },

    -- Dev icons
    -- https://github.com/nvim-tree/nvim-web-devicons
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },

    -- Mini icons
    -- https://github.com/echasnovski/mini.icons
    {
        'echasnovski/mini.icons',
        lazy = true,
    },

}

-- vim: ts=4 sts=4 sw=4 et
