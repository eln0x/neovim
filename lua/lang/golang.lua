-- Neovim Golang
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = {
                "go",
                "gomod",
                "gowork",
                "gotmpl"
            },
            root = {
                "go.work",
                "go.mod"
            },
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "go", "gomod", "gowork", "gosum", "gotmpl" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "gopls",                                            -- language server protocol
                "goimports", "gofumpt", "golines", "gomodifytags",  -- formatter
                "golangci-lint",                                    -- linter
                "impl",                                             -- helper
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
                go = { "golangcilint" },
            },
            linters = {
            },
        },
    },
    -- ✨ Conform: Formatting
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofumpt", "golines" },
            },
            formatters = {
                goimports = {
                    command = "goimports",
                    stdin = true,
                },
                gofumpt = {
                    command = "gofumpt",
                    stdin = true,
                },
                golines = {
                    command = "golines",
                    args = { "--max-len=100" },
                    stdin = true,
                },
            },
        }
    },
    -- 🪄 None-ls: Formatters & Linters via LSP.
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.gofumpt,
                nls.builtins.diagnostics.golangci_lint,
            })
        end,
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                gopls = {
                    cmd = { "gopls" },
                    filetypes = { "go", "gomod" },
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                                unreachable = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            semanticTokens = true,
                        },
                    },
                },
            },
        },
        setup = {
            gopls = function(_, opts)
                -- workaround for gopls not supporting semanticTokensProvider
                -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
                Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
                    if not client.server_capabilities.semanticTokensProvider then
                        local semantic = client.config.capabilities.textDocument.semanticTokens
                        client.server_capabilities.semanticTokensProvider = {
                            full = true,
                            legend = {
                                tokenTypes = semantic.tokenTypes,
                                tokenModifiers = semantic.tokenModifiers,
                            },
                            range = true,
                        }
                    end
                end)
                -- end workaround
            end,
        },
    },
    -- 🌍 Icons: Go-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            file = {
                [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
            },
            filetype = {
                go = { glyph = "", hl = "MiniIconsBlue" },
                gomod = { glyph = "", hl = "MiniIconsYellow" },
                gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
            },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
