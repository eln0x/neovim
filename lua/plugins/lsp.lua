-- Neovim Lsp
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🖥️ LSP Core: Language server protocol setup
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
                -- options for vim.lsp.buf.format
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },
                -- LSP Server Settings
                servers = {
                    -- configuration for all lsp servers
                    ["*"] = {
                        capabilities = {
                            workspace = {
                                fileOperations = {
                                    didRename = true,
                                    willRename = true,
                                },
                            },
                        },
                        -- stylua: ignore
                        keys = {
                            { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
                            { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
                            { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
                            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
                            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
                            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
                            { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
                            { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
                            { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
                            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
                            { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
                            { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
                            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
                            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
                            { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
                            { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
                                desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
                            { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
                                desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
                            { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
                                desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
                            { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
                                desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
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

                -- linter
                "codespell",
                "typos",
            },
        }
    },

    -- INFO: LazyVim extra --

    -- 🪄 Formatters & Linters via LSP.
    -- https://github.com/nvimtools/none-ls.nvim
    {
        "nvimtools/none-ls.nvim",
        event = "LazyFile",
        dependencies = { "mason.nvim" },
        opts = function(_, opts)
            opts.root_dir = opts.root_dir
            or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
            opts.sources = vim.list_extend(opts.sources or {}, {
            })
        end,
    },

    -- TEST: External plugins --

}

-- vim: ts=4 sts=4 sw=4 et
