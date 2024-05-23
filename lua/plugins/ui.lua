-- Neovim UI
-- stylua: ignore
--if true then return {} end

return {
    -- Startup screen
    -- https://github.com/goolord/alpha-nvim
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        enabled = true,
        init = false,
        opts = function()
            local fortune   = require("alpha.fortune")
            local dashboard = require("alpha.themes.dashboard")
            local devicons  = require("nvim-web-devicons")
            local cdir      = vim.fn.getcwd()

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
                ignore = function(path, ext)
                    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
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
                [[              .___                 .__             ]],
                [[            __| _/_______  __ ____ |  |            ]],
                [[           / __ |/ __ \  \/ // __ \|  |            ]],
                [[          / /_/ \  ___/\   /\  ___/|  |__          ]],
                [[          \____ |\___  >\_/  \___  >____/          ]],
                [[               \/    \/          \/                ]],
            }

            local section_header = {
                type = "text",
                val = logo,
                opts = {
                    hl = "Operator",
                    shrink_margin = false,
                    position = "center",
                },
            }

            local section_mru = {
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

            local section_buttons = {
                type = "group",
                val = {
                    { type = "text", val = "Quick links", opts = { hl = "Constant", position = "center" } },
                    { type = "padding", val = 1 },
                    dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
                    dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
                    dashboard.button("p", " " .. " Find project", "<cmd> Telescope projects <cr>"),
                    dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
                    dashboard.button("m", " " .. " Find modified file", "<cmd> Telescope git_status <cr>"),
                    dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
                    dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                    dashboard.button("c", " " .. " Config", "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
                    dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                    dashboard.button("h", " " .. " Check health", "<cmd> checkhealth <cr>"),
                    dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
                },
                position = "center",
            }

            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local footer_text = fortune()

            table.insert(footer_text, "")
            table.insert(footer_text, "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms")

            local section_footer = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = footer_text,
                        opts = { hl = "Constant", position = "center" },
                    },
                },
            }

            local opts = {
                layout = {
                    { type = "padding", val = 1 },
                    section_header,
                    { type = "padding", val = 1 },
                    section_mru,
                    { type = "padding", val = 1 },
                    section_buttons,
                    section_footer,
                },
                opts = {
                    margin = 5,
                },
            }

            dashboard.opts = opts
            return dashboard
        end,
    },

    -- Buffer line
    -- https://github.com/akinsho/bufferline.nvim
    {
        'akinsho/bufferline.nvim',
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
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("lazyvim.config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
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
            highlights = {
                fill = {
                    fg = { attribute = "fg", highlight = "TabLineSel" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                background = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                buffer_selected = {
                    fg = {attribute='fg',highlight='TabLineSel'},
                    bg = {attribute='bg',highlight='TabLine'},
                    underline = false,
                },
                buffer_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                close_button = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                close_button_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                close_button_selected = {
                    fg = {attribute='fg',highlight='TabLineSel'},
                    bg ={attribute='bg',highlight='TabLineSel'}
                },
                tab_selected = {
                    fg = { attribute = "fg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                tab = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                tab_close = {
                    fg = { attribute = "fg", highlight = "TabLineSel" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                duplicate_selected = {
                    fg = { attribute = "fg", highlight = "TabLineSel" },
                    bg = { attribute = "bg", highlight = "TabLineSel" },
                    italic = true,
                },
                duplicate_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                    italic = true,
                },
                duplicate = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                    italic = true,
                },
                modified = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                modified_selected = {
                    fg = { attribute = "fg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                modified_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                separator = {
                    fg = { attribute = "bg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                separator_selected = {
                    fg = { attribute = "bg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                separator_visible = {
                    fg = {attribute='bg',highlight='TabLine'},
                    bg = {attribute='bg',highlight='TabLine'}
                },
                indicator_selected = {
                    fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
            },
        },
    },

    -- Status line
    -- https://github.com/nvim-lualine/lualine.nvim
    {
        'nvim-lualine/lualine.nvim',
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            vim.o.laststatus = vim.g.lualine_laststatus

            local hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "warn", "error" },
                symbols = { warn = " ", error = " " },
                colored = true,
                update_in_insert = false,
                always_visible = true,
            }

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

            local date = {
                "mode",
                fmt = function()
                    return " " .. os.date("%R")
                end,
            }

            local spaces = function()
                return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end

            return {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    disabled_filetypes = {
                        statusline = {
                            "dashboard",
                            "alpha",
                            "starter",
                            "NvimTree",
                            "Outline",
                        }
                    },
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch, 'diff', diagnostics},
                    lualine_c = { },
                    lualine_x = {
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        },
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                        },
                        'filetype', spaces, 'encoding', 'fileformat'

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
                    },
                    lualine_z = { date },
                },
                extensions = { "neo-tree", "lazy" },
            }
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
    },

    -- UI for messages, cmdline and the popupmenu.
    -- https://github.com/folke/noice.nvim
    {
        'folke/noice.nvim',
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
    },

    -- UI components
    -- https://github.com/MunifTanjim/nui.nvim
    {
        'MunifTanjim/nui.nvim',
    },

    -- Lua Gui and utils
    -- https://github.com/ray-x/guihua.lua
    {
        'ray-x/guihua.lua',
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
    },

}

-- vim: ts=4 sts=4 sw=4 et
