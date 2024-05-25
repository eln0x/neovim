-- Colors
-- stylua: ignore
--if true then return {} end

return {
    -- Theme creation helper
    {
            'rktjmp/shipwright.nvim',
    },

    -- Jellybeans port to lua
    -- https://github.com/nanotech/jellybeans.vim
    {
        'metalelf0/jellybeans-nvim',
        dependencies = {
        'rktjmp/lush.nvim',
        },
    },

    -- configure LazyVim to load jellybeans
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "jellybeans-nvim",
        },
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
