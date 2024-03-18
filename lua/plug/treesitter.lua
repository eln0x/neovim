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

--
-- Treesitter context configuration
--
-- https://github.com/nvim-treesitter/nvim-treesitter-context

local ctx_ok, context = pcall(require, "treesitter-context")
if not ctx_ok then
    return
end

-- default setup
context.setup({
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
})
