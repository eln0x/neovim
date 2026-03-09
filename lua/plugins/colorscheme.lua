-- Colors
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🌌 Tokyonight: Dark theme with multiple styles
    -- https://github.com/folke/tokyonight.nvim
    {
        "folke/tokyonight.nvim",
        opts = { style = "night" },
    },

    -- TEST: External plugins --

    -- 🌈 Highlight color codes in buffers
    -- https://github.com/norcalli/nvim-colorizer.lua
    {
        'norcalli/nvim-colorizer.lua',
        init = function()
            require 'colorizer'.setup()
        end
    },
}

-- vim: ts=4 sts=4 sw=4 et
