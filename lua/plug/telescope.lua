--
-- Telescope configuration
--
-- https://github.com/nvim-telescope/telescope.nvim

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local actions = require "telescope.actions"

-- setup
telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        borderchars = {
            prompt = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
            preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
            results = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
    },
    extensions = {
        repo = {
            list = {
                fd_opts = {
                    "--no-ignore-vcs",
                },
                search_dirs = {
                    "~/sources/gitlab",
                },
            },
        },
    },
})

-- load extensions
require("telescope").load_extension "repo"

-- customize ui
vim.cmd([[
    hi TelescopePromptBorder guifg=#f2594b guibg=#282828
    hi TelescopePromptNormal  guifg=#f2594b guibg=#282828
    hi TelescopePromptTitle  guifg=#f2594b guibg=#282828
    hi TelescopePromptPrefix  guifg=#f2594b guibg=#282828
    hi TelescopePromptCounter  guifg=#f2594b guibg=#282828
    hi TelescopePreviewTitle  guifg=#8bba7f guibg=#282828
    hi TelescopePreviewBorder guifg=#8bba7f guibg=#282828
    hi TelescopeResultsTitle  guifg=#8bba7f guibg=#282828
    hi TelescopeResultsBorder guifg=#8bba7f guibg=#282828
    hi TelescopeMatching guifg=#e9b143 guibg=#282828
    hi TelescopeSelection guifg=#ffffff guibg=#32302f
]])
