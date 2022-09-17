--
-- Indent line configuration
--
-- https://github.com/lukas-reineke/indent-blankline.nvim

local indent_ok, indent = pcall(require, "indent_blankline")
if not indent_ok then
    return
end

indent.setup {
    char = '┊',
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "packer",
        "NvimTree",
    },
}
