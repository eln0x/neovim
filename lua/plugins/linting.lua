-- Neovim Linting
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🩺 Code linting
    -- https://github.com/mfussenegger/nvim-lint
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {},
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
