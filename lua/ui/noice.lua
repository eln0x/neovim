--
-- Noice configuration
--
-- https://github.com/folke/noice.nvim

local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
    return
end

noice.setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        -- set to disable if `vim.lsp.handlers["window/showMessage"]` has been overwritten by another plugin.
        signature = {
            enabled = true,
        },
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    presets = {
        bottom_search = false,          -- popup cmdline for search
        command_palette = true,         -- position the cmdline and popupmenu together
        long_message_to_split = true,   -- long messages will be sent to a split
        inc_rename = true,              -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,         -- add a border to hover docs and signature help
    },
})

-- vim: ts=4 sts=4 sw=4 et
