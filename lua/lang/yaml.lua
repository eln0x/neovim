-- Neovim Yaml
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "yaml", "yml" },
            root = { ".git" },
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "yaml" } },

    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "yaml-language-server",     -- language server protocol
                "yamlfmt", "yamlfix",       -- formatter
                "yamllint",                 -- linter
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
                yaml = { "yamllint" },
                yml = { "yamllint" },
            },
            linters = {
                yamllint = {
                    cmd = "yamllint",
                    args = { "--format", "parsable", "-" },
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
                yaml = { "yamlfmt", "yamlfix" },
                yml = { "yamlfmt", "yamlfix" },
            },
            formatters = {
                yamlfmt = {
                    command = "yamlfmt",
                    stdin = true,
                },
                yamlfix = {
                    command = "yamlfix",
                    args = { "-" },
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
                yamlls = {
                    cmd = { "yaml-language-server", "--stdio" },
                    filetypes = { "yaml", "yml" },
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = { enable = true },
                            validate = true,
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                        },
                    },
                    capabilities = {
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    before_init = function(_, new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            "force",
                            new_config.settings.yaml.schemas or {},
                            require("schemastore").yaml.schemas()
                        )
                    end,
                },
            },
        },
    },
    -- 🌍 Icons for Yaml-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                yaml = { glyph = "", hl = "MiniIconsYellow" },
                yml = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
    },
    -- 📦 YAML SchemaStore support
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
}

-- vim: ts=4 sts=4 sw=4 et
