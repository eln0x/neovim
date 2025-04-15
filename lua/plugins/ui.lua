-- Neovim UI
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🗂 Buffer line (tabs & buffers)
    -- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        enabled = true,
        opts = {
            options = {
                always_show_bufferline = true,
                enforce_regular_tabs = true,
                max_name_length = 30,
                max_prefix_length = 30,
                tab_size = 21,
                separator_style = "thin",
                indicator = {
                    icon = '',
                    style = 'icon',
                },
            },
        },
    },

    -- 📊 Status line
    -- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        opts = function()
            local icons = LazyVim.config.icons

            vim.o.laststatus = vim.g.lualine_laststatus

            local mode = {
                "mode",
                fmt = function(str)
                    return " " .. str .. " -"
                end,
            }

            local branch = {
                "branch",
                icons_enabled = true,
                icon = "",
            }

            local diagnostics = {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error,
                    warn = icons.diagnostics.Warn,
                    info = icons.diagnostics.Info,
                    hint = icons.diagnostics.Hint,
                },
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

            local date = {
                "mode",
                fmt = function()
                    return " " .. os.date("%R") .. " "
                end,
            }

            local spaces = function()
                return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end

            local linter = function()
                local linters = require("lint").get_running()
                if #linters == 0 then
                    return "󰦕"
                end
                return "󱉶 " .. table.concat(linters, ", ")
            end

            local opts = {
                options = {
                    theme = "auto",
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch, diff },
                    lualine_c = {
                        LazyVim.lualine.root_dir(),
                        diagnostics,
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { LazyVim.lualine.pretty_path() },
                        { linter },
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
                        spaces, 'encoding', 'fileformat',
                    },
                    lualine_z = { date },
                },
                extensions = { "neo-tree", "lazy", "fzf" },
            }

            return opts
        end,
    },

    -- 💬 UI for messages, cmdline & popupmenu
    -- https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        enabled = true,
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
    },

    -- 🖼 Icons for files & filetypes
    -- https://github.com/nvim-mini/mini.icons
    {
        "nvim-mini/mini.icons",
        enabled = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
    },

    -- 🧩 UI components library
    -- https://github.com/MunifTanjim/nui.nvim
    {
        'MunifTanjim/nui.nvim',
        enabled = true,
    },

    -- 🥪 Snacks UI helpers
    -- https://github.com/folke/snacks.nvim
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = { enabled = false },    -- alpha
            bigfile = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },                   -- use comfortable-motion instead
            statuscolumn = { enabled = false },             -- we set this in options.lua
            toggle = { map = LazyVim.safe_keymap_set },
            words = { enabled = true },
            explorer = { enabled = true },
        },
    },

    -- INFO: LazyVim extra --

    -- 🚀 Startup screen/dashboard
    -- https://github.com/goolord/alpha-nvim
    {
        'goolord/alpha-nvim',
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
                        val = " Recent files ",
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
                    { type = "text", val = " Quick links ", opts = { hl = "Constant", position = "center" } },
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
    },

    -- TEST: External plugins --

    -- 🌀 Smooth scrolling
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },
}

-- vim: ts=4 sts=4 sw=4 et
