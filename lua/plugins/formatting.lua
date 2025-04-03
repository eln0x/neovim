-- Neovim Formatting
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Lightweight yet powerful formatter
    -- https://github.com/stevearc/conform.nvim
    {
        "stevearc/conform.nvim",
        enabled = true,
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
            },
            formatters = {
                injected = { options = { ignore_errors = true } },
            },
        }
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
