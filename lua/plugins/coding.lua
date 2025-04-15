-- Neovim Coding
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🧩 Automatically insert matching brackets, quotes, etc.
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

    -- 💬 Enhanced commenting with treesitter support
    -- https://github.com/folke/ts-comments.nvim
    {
        "folke/ts-comments.nvim",
        enabled = true,
        opts = {},
    },

    -- ✂️ Better text objects for motions and editing
    -- https://github.com/nvim-mini/mini.ai
    {
        "nvim-mini/mini.ai",
        enabled = true,
    },

    -- 🛠️ Lua language enhancements for Neovim config
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

    -- 📝 Generate docstrings and annotations
    -- https://github.com/danymat/neogen
    {
        "danymat/neogen",
    }

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
