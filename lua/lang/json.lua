-- Neovim Json
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "json", "jsonc", "json5" },
            root = { ".git" },
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "json", "json5" } },

    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "json-lsp",     -- language server protocol
                "prettier",     -- formatter
                "jsonlint",     -- linter
            }
            for _, tool in ipairs(new) do
                if not vim.tbl_contains(opts.ensure_installed, tool) then
                    table.insert(opts.ensure_installed, tool)
                end
            end
        end,
    },
    -- 🧹 Linting: Code quality checks
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
                jsonc = { "jsonlint" },
            },
            linters = {
                jsonlint = {
                    cmd = "jsonlint",
                    args = { "--compact" },
                    stdin = true,
                },
            },
        },
    },
    -- ✨ Conform: Formatting
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
            },
            formatters = {
                prettier = {
                    command = "prettier",
                    args = { "--parser", "json" },
                    stdin = true,
                },
            },
        }
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                jsonls = {
                    cmd = { "vscode-json-language-server", "--stdio" },
                    filetypes = { "json", "jsonc" },
                    settings = {
                        json = {
                            validate = { enable = true },
                            format = { enable = true },
                        },
                    },
                    capabilities = {
                        textDocument = {
                            completion = {
                                completionItem = {
                                    snippetSupport = true,
                                },
                            },
                        },
                    },
                    before_init = function(_, new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                },
            },
        },
    },
    -- 🌍 Icons for Json-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                json = { glyph = "", hl = "MiniIconsYellow" },
                jsonc = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
    },
    -- 📦 JSON SchemaStore support
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
}

-- vim: ts=4 sts=4 sw=4 et
