-- Neovim Formatting
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🧹 Code formatting manager
    -- https://github.com/stevearc/conform.nvim
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {},
        }
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
