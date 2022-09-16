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
        "json",
        "latex",
        "lua",
        "make",
        "markdown",
        "perl",
        "python",
        "rust",
        "sql",
        "toml",
        "vim",
        "yaml",
    },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ignore_install = {},
})
