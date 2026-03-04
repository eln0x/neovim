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
            dashboard = { enabled = false },            -- alpha
            bigfile = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },               -- use comfortable-motion instead
            statuscolumn = { enabled = false },         -- we set this in options.lua
            toggle = { map = LazyVim.safe_keymap_set },
            words = { enabled = true },
            explorer = { enabled = true },
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

    -- 🌀 Smooth scrolling
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },
}

-- vim: ts=4 sts=4 sw=4 et
