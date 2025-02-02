--
-- Bufferline configuration
--
-- https://github.com/akinsho/bufferline.nvim

local bufline_ok, bufferline = pcall(require, "bufferline")
if not bufline_ok then
    return
end

bufferline.setup {
    options = {
        always_show_bufferline = true,
        enforce_regular_tabs = true,
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        buffer_close_icon = '',
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                padding = 1
            },
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left",
            },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        indicator = {
            icon = '',
            style = 'icon',
        },
    },
    highlights = {
        fill = {
            fg = { attribute = "fg", highlight = "TabLineSel" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        background = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        buffer_selected = {
            fg = {attribute='fg',highlight='TabLineSel'},
            bg = {attribute='bg',highlight='TabLine'},
            underline = false,
        },
        buffer_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button_selected = {
            fg = {attribute='fg',highlight='TabLineSel'},
            bg ={attribute='bg',highlight='TabLineSel'}
        },
        tab_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        tab = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        tab_close = {
            fg = { attribute = "fg", highlight = "TabLineSel" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        duplicate_selected = {
            fg = { attribute = "fg", highlight = "TabLineSel" },
            bg = { attribute = "bg", highlight = "TabLineSel" },
            italic = true,
        },
        duplicate_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
            italic = true,
        },
        duplicate = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
            italic = true,
        },
        modified = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        modified_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        modified_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        separator = {
            fg = { attribute = "bg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "TabLine" },
        },
        separator_selected = {
            fg = { attribute = "bg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        separator_visible = {
            fg = {attribute='bg',highlight='TabLine'},
            bg = {attribute='bg',highlight='TabLine'}
        },
        indicator_selected = {
            fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
