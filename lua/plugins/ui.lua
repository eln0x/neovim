-- Neovim UI
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🗂 Buffer line (tabs & buffers)
    -- https://github.com/akinsho/bufferline.nvim
    {
        "akinsho/bufferline.nvim",
        enabled = true,
        opts = {
            options = {
                always_show_bufferline = true,
                max_name_length = 30,
                max_prefix_length = 30,
                tab_size = 21,
            },
        },
    },

    -- 💬 UI for messages, cmdline & popupmenu
    -- https://github.com/folke/noice.nvim
    {
        "folke/noice.nvim",
        enabled = true,
        opts = {
            lsp = {
                -- set to disable if `vim.lsp.handlers["window/showMessage"]` has been overwritten by another plugin.
                signature = {
                    enabled = true,
                },
            },
            presets = {
                bottom_search = false,          -- popup cmdline for search
                inc_rename = true,              -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,          -- add a border to hover docs and signature help
            },
        },
    },
    -- 🥪 Snacks UI helpers
    -- https://github.com/folke/snacks.nvim
    {
        "folke/snacks.nvim",
        opts = {
            scroll = { enabled = false },   -- use comfortable-motion instead
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

    -- 🌀 Smooth scrolling
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },
}

-- vim: ts=4 sts=4 sw=4 et
