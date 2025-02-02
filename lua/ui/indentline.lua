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

--
-- Mini Indent scope configuration
--
-- https://github.com/echasnovski/mini.indentscope

local iscope_ok, iscope = pcall(require, "mini.indentscope")
if not iscope_ok then
    return
end

iscope.setup({
    draw = {
        delay = 100,
        priority = 2,
    },
    mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '[i',
        goto_bottom = ']i',
    },
    options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = true,
    },
    symbol = '┊',
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
    },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

-- vim: ts=4 sts=4 sw=4 et
