--
-- Indent line configuration
--
-- https://github.com/lukas-reineke/indent-blankline.nvim

local indent_ok, indent = pcall(require, "ibl")
if not indent_ok then
    return
end

indent.setup {
    indent = {
        char = "┊",
        tab_char = "│",
    },
    exclude = {
        buftypes = {
            "terminal",
            "nofile"
        },
        filetypes = {
            "help",
            "alpha",
            "dashboard",
            "NvimTree",
            "neo-tree",
            "Trouble",
            "trouble",
            "packer",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
        },
    },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = true },
}
local hooks = require "ibl.hooks"
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_tab_indent_level
)

-- vim: ts=4 sts=4 sw=4 et
