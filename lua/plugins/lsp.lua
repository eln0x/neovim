-- Neovim Lsp
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🖥️ LSP Core: Language server protocol setup
    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                underline = false,
            },
            servers = {},
        },
    },

    -- 🛠️ Manage external LSPs, formatters, linters
    -- https://github.com/mason-org/mason.nvim
    {
        "mason-org/mason.nvim",
        enabled = true,
        opts = {
            ensure_installed = {
                -- language server protocol
                "puppet-editor-services",
                "perlnavigator",

                -- formatter
                "prettier",

                -- linter
                "codespell",
                "typos",
            },
        }
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
