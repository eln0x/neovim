-- Colors
-- stylua: ignore
--if true then return {} end

return {
    -- configure LazyVim to load jellybeans
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "jellybeans-nvim",
        },
    },

    -- Theme creation helper
    {
        'rktjmp/lush.nvim',
    },

    -- Jellybeans port to lua
    -- https://github.com/nanotech/jellybeans.vim
    {
        'metalelf0/jellybeans-nvim',
        lazy = false,
        priority = 1000,
        dependencies = {
            'rktjmp/shipwright.nvim',
        },
    },

    -- Tokyonight
    {
        'folke/tokyonight.nvim',
        opts = { style = "night" },
    },

    -- Lunar
    {
        'lunarvim/darkplus.nvim',
    },

    -- Color highlighter
    {
        'NvChad/nvim-colorizer.lua',
        init = function()
            require 'colorizer'.setup()
        end
    },
}

-- vim: ts=4 sts=4 sw=4 et
