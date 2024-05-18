-- Colors
-- stylua: ignore
--if true then return {} end

return {
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
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd([[colorscheme jellybeans-nvim]])
        end,
    },

    -- Tokyonight
    {
        'folke/tokyonight.nvim',
        opts = { style = "moon" },
    },

    -- Lunar
    {
        'lunarvim/darkplus.nvim',
    },

    -- Color highlighter
    {
        'NvChad/nvim-colorizer.lua',
    }

}

-- vim: ts=4 sts=4 sw=4 et
