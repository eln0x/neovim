--
-- Lualine configuration
--
-- https://github.com/nvim-lualine/lualine.nvim

local lual_ok, lualine = pcall(require, "lualine")
if not lual_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "warn", "error" },
    symbols = { warn = " ", error = " " },
    colored = true,
    update_in_insert = false,
    always_visible = true,
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "powerline_dark",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = { "alpha", "NvimTree", "Outline" },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, 'diff', diagnostics},
        lualine_c = {},
        lualine_x = { 'filetype', spaces, 'encoding', 'fileformat' },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
