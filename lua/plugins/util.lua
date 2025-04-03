-- Neovim Util
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Automated session management
    -- https://github.com/folke/persistence.nvim
    {
        "folke/persistence.nvim",
        enabled = true,
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
            options = {
                "buffers",
                "curdir",
                "tabpages",
                "winsize"
            },
        },
    },

    -- Library used by other plugins
    -- https://github.com/nvim-lua/plenary.nvim
    {
        'nvim-lua/plenary.nvim',
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

    -- HAProxy syntax
    -- https://github.com/Joorem/vim-haproxy
    {
        'Joorem/vim-haproxy',
    },
}

-- vim: ts=4 sts=4 sw=4 et
