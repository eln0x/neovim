--
-- Treesitter configuration
--
-- https://github.com/nvim-treesitter/nvim-treesitter

local treesitter_ok, configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
    return
end

-- setup
configs.setup({
    ensure_installed = {
        "bash",
        "c",
        "comment",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "gotmpl",
        "json",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "python",
        "regex",
        "rust",
        "sql",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },
    sync_install = false,
    auto_install = false,
    highlight = { enable = true, disable = {} },
    indent = { enable = true, disable = {} },
})

-- vim: ts=4 sts=4 sw=4 et
