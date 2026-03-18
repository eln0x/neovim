-- Colors
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🎨 Set the preferred colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight-moon",
        },
    },

    -- 🌌 Tokyonight: Dark theme with multiple styles
    -- https://github.com/folke/tokyonight.nvim
    {
        "folke/tokyonight.nvim",
        opts = { style = "moon" },
    },

    -- TEST: External plugins --

    -- 🛠️ Create your own colorschemes
    -- https://github.com/rktjmp/lush.nvim
    {
        'rktjmp/lush.nvim',
    },

    -- 🟢 Jellybeans Lua port
    -- https://github.com/nanotech/jellybeans.vim
    {
        'metalelf0/jellybeans-nvim',
        dependencies = {
            'rktjmp/shipwright.nvim',
        },
    },

    -- 🌈 Highlight color codes in buffers
    -- https://github.com/norcalli/nvim-colorizer.lua
    {
        'norcalli/nvim-colorizer.lua',
        init = function()
            require 'colorizer'.setup()
        end
    },

    -- 🎛️ Dynamically manage and switch themes
    -- https://github.com/vague2k/huez.nvim
    {
        "vague2k/huez.nvim",
        dependencies = { 'nvim-telescope/telescope.nvim' },
        -- if you want registry related features, uncomment this
        import = "huez-manager.import",
        branch = "stable",
        event = "UIEnter",
        config = function()
            require("huez").setup({
                fallback = "tokyonight-moon",
                suppress_messages = false,
            })
        end,
    }
}

-- vim: ts=4 sts=4 sw=4 et
