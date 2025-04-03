-- Neovim Lsp
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Language server proto
    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        opts = function()
            local ret = {
                -- Options for vim.diagnostic.config()
                diagnostics = {
                    underline = false,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "●",
                    },
                    severity_sort = true,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
                            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
                            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
                            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
                        },
                    },
                },
                -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
                inlay_hints = {
                    enabled = true,
                    exclude = { "vue" },
                },
                -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
                codelens = {
                    enabled = false,
                },
                -- Enable this to enable the builtin LSP folding on Neovim.
                folds = {
                    enabled = true,
                },
                -- Add any global capabilities here
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                -- options for vim.lsp.buf.format
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },
                -- LSP Server Settings
                servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                workspace = {
                                    checkThirdParty = false,
                                },
                                codeLens = {
                                    enable = true,
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                doc = {
                                    privateName = { "^_" },
                                },
                                hint = {
                                    enable = true,
                                    setType = false,
                                    paramType = true,
                                    paramName = "Disable",
                                    semicolon = "Disable",
                                    arrayIndex = "Disable",
                                },
                            },
                        },
                    },
                },
                -- you can do any additional lsp server setup here
                setup = {
                    -- example to setup with typescript.nvim
                    -- tsserver = function(_, opts)
                    --   require("typescript").setup({ server = opts })
                    --   return true
                    -- end,
                    -- Specify * to use this function as a fallback for any server
                    -- ["*"] = function(server, opts) end,
                },
            }
            return ret
        end
    },

    -- Manage external editors
    -- https://github.com/mason-org/mason.nvim
    {
        "mason-org/mason.nvim",
        enabled = true,
        opts = {
            ensure_installed = {
                -- language server protocol
                "bash-language-server",
                "lua-language-server",
                "puppet-editor-services",
                "perlnavigator",
                "python-lsp-server",

                -- formatter
                "stylua",
                "shfmt",

                -- linter
                "shellcheck",
            },
        }
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

}

-- vim: ts=4 sts=4 sw=4 et
