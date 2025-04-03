-- Neovim Treesitter
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Syntax highlightings
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "awk",
                "bash",
                "c",
                "comment",
                "diff",
                "dockerfile",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "gotmpl",
                "helm",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "latex",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "perl",
                "printf",
                "puppet",
                "python",
                "regex",
                "rust",
                "sql",
                "terraform",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
    },

    -- Treesitter for textobjects
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = true,
        opts = {},
    },

    -- Automatically add closing tags for HTML and JSX
    -- https://github.com/windwp/nvim-ts-autotag
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        event = "LazyFile",
        opts = {},
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
