--
-- Lualine configuration
--
-- https://github.com/nvim-lualine/lualine.nvim

local vim = vim

local lual_ok, lualine = pcall(require, "lualine")
if not lual_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

vim.o.laststatus = vim.g.lualine_laststatus

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

local diff = {
    "diff",
    symbols = {
        added = " "  ,
        modified = " ",
        removed = " "  ,
    },
    source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "warn", "error", "hint" },
    symbols = {
        error = " "  ,
        warn = " "  ,
        hint = " "  ,
        info = " "  ,
    },
    colored = true,
    update_in_insert = false,
    always_visible = false,
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
        theme = "ayu_dark",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "NvimTree" } },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1
            },
            diagnostics,
        },
        lualine_x = {
            -- stylua: ignore
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            -- stylua: ignore
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            -- stylua: ignore
            {
                function() return "  " .. require("dap").status() end,
                cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
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
            {
                "filetype",
                icon_only = false,
                separator = "",
                padding = { left = 1, right = 0 }
            },
            spaces, 'encoding', 'fileformat',
        },
        lualine_z = { date },
    },
    extensions = { "neo-tree", "lazy" },
})

-- vim: ts=4 sts=4 sw=4 et
