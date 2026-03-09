-- Neovim Treesitter
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🌳 Syntax highlighting & parsing
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "awk",
                "c",
                "comment",
                "diff",
                "dockerfile",
                "helm",
                "html",
                "javascript",
                "jsdoc",
                "latex",
                "perl",
                "printf",
                "puppet",
                "regex",
                "rust",
                "sql",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
            },
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
