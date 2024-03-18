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

local date = {
    "mode",
    fmt = function()
        return " " .. os.date("%R")
    end,
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = { "alpha", "NvimTree", "Outline" },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, 'diff', diagnostics},
        lualine_c = { },
        lualine_x = {
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
            },
            'filetype', spaces, 'encoding', 'fileformat'

        },
        lualine_y = {
            {
                "progress",
                separator = " ",
                padding = { left = 1, right = 0 }
            },
            {
                "location",
                padding = { left = 0, right = 1 }
            },
        },
        lualine_z = { date },
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
    extensions = { "lazy" },
})
