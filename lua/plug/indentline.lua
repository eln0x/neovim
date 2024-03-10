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
    },
    exclude = {
        buftypes = { "terminal", "nofile" },
        filetypes = { "help", "packer", "NvimTree" }
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
