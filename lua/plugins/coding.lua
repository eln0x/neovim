-- Neovim Coding
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Auto pairs
    -- https://github.com/nvim-mini/mini.pairs
    {
        "nvim-mini/mini.pairs",
        enabled = true,
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            skip_unbalanced = true,
            markdown = true,
        },
    },

    -- Comments
    -- https://github.com/folke/ts-comments.nvim
    {
        "folke/ts-comments.nvim",
        enabled = true,
        opts = {},
    },

    -- Better text-objects
    -- https://github.com/nvim-mini/mini.ai
    {
        "nvim-mini/mini.ai",
        enabled = true,
    },

    -- Configures LuaLS for editing your Neovim config
    -- https://github.com/folke/lazydev.nvim
    {
        "folke/lazydev.nvim",
        enabled = true,
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "LazyVim", words = { "LazyVim" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },

    -- INFO: LazyVim extra --

    -- Annotations toolkit
    -- https://github.com/danymat/neogen
    {
        "danymat/neogen",
    }

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
