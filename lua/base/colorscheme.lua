-- Colors
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Wanted colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "jellybeans-nvim",
        },
    },

    -- Tokyonight
    -- https://github.com/folke/tokyonight.nvim
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = { style = "moon" },
    },

    -- Catppuccin
    -- https://github.com/catppuccin/nvim
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        opts = {
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                fzf = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                snacks = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
        specs = {
            {
                "akinsho/bufferline.nvim",
                optional = true,
                opts = function(_, opts)
                    if (vim.g.colors_name or ""):find("catppuccin") then
                        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
                    end
                end,
            },
        },
    },

    -- TEST: External plugins --

    -- Theme creation helper
    -- https://github.com/rktjmp/lush.nvim
    {
        'rktjmp/lush.nvim',
    },

    -- Jellybeans port to lua
    -- https://github.com/nanotech/jellybeans.vim
    {
        'metalelf0/jellybeans-nvim',
        dependencies = {
            'rktjmp/shipwright.nvim',
        },
    },

    -- Color highlighter
    -- https://github.com/norcalli/nvim-colorizer.lua
    {
        'norcalli/nvim-colorizer.lua',
        init = function()
            require 'colorizer'.setup()
        end
    },
}

-- vim: ts=4 sts=4 sw=4 et
