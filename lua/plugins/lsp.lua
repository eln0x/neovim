-- Lsp
-- stylua: ignore
--if true then return {} end

local vim = vim

return {
    -- Install or upgrade 3rd party tools
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function()
            -- define wanted servers
            local SERVERS = {
                -- language server protocol
                "bash-language-server",
                "lua-language-server",
                "vim-language-server",
                "gopls",
                "clangd",
                "python-lsp-server",
                "perlnavigator",
                "rust-analyzer",
                "puppet-editor-services",
                "dockerfile-language-server",
                "terraform-ls",
                "ansible-language-server",
                "yaml-language-server",
                "json-lsp",
                "marksman",

                -- formatter
                "shfmt",
                "stylua",
                "goimports",
                "clang-format",
                "black",
                "yamlfmt",
                "prettier",

                -- linter
                "shellcheck",
                "selene",
                "golangci-lint",
                "cpplint",
                "flake8",
                "ansible-lint",
                "yamllint",
            }
            return {
                ensure_installed = SERVERS,
                auto_update = false,
                run_on_start = true,
            }
        end,
        config = function(_, opts)
            require("mason-tool-installer").setup(opts)
        end,
    },

    -- Language server proto
    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = function()
            -- define capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_ok, cmp = pcall(require, 'cmp_nvim_lsp')
            if cmp_ok then
                capabilities = cmp.default_capabilities(capabilities)
            end
            local ret = {
                capabilities = capabilities,
                -- Configure diagnostics
                diagnostics = {
                    virtual_text = {
                        spacing = 2,
                        source = "if_many",
                        prefix = "●",
                    },
                    float = {
                        border = 'rounded',
                        source = "if_many",
                    },
                    severity_sort = true,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = '✘',
                            [vim.diagnostic.severity.WARN] = '▲',
                            [vim.diagnostic.severity.HINT] = '',
                            [vim.diagnostic.severity.INFO] = '',
                        },
                    },
                },
                flags = {
                    debounce_text_changes = 150,
                },
                -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
                inlay_hints = {
                    enabled = true,
                    exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
                },
                -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
                codelens = {
                    enabled = false,
                },
                on_attach = function(client, bufnr)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                    -- Info keymaps
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "?", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, bufopts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                    vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, bufopts)
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)

                    -- Workspaces keymaps
                    vim.keymap.set("n", "wa", vim.lsp.buf.add_workspace_folder, bufopts)
                    vim.keymap.set("n", "wr", vim.lsp.buf.remove_workspace_folder, bufopts)
                    vim.keymap.set("n", "wl", vim.lsp.buf.list_workspace_folders, bufopts)

                    -- Action keymaps
                    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set('x', 'ga', vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)

                    -- Diagnostics keymaps
                    vim.keymap.set('n', 'do', vim.diagnostic.open_float, bufopts)
                    vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev, bufopts)
                    vim.keymap.set('n', 'dn', vim.diagnostic.goto_next, bufopts)
                    vim.keymap.set('n', 'dl', "<cmd>Telescope diagnostics<cr>", bufopts)

                    -- Format keymaps
                    if client.server_capabilities.documentFormattingProvider then
                        vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.formatting()<CR>")
                    end

                    if client.server_capabilities.documentRangeFormattingProvider then
                        vim.cmd("nnoremap <silent><buffer> gF :lua vim.lsp.buf.range_formatting()<CR>")
                    end

                    -- Highlight symbols
                    if client.server_capabilities.documentHighlightProvider then
                        vim.cmd [[
                            hi! LspReferenceRead cterm=bold ctermbg=000 guibg=#282828
                            hi! LspReferenceText cterm=bold ctermbg=000 guibg=#282828
                            hi! LspReferenceWrite cterm=bold ctermbg=000 guibg=#282828
                        ]]
                        vim.api.nvim_create_augroup('lsp_document_highlight', {})
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            group = 'lsp_document_highlight',
                            buffer = 0,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd('CursorMoved', {
                            group = 'lsp_document_highlight',
                            buffer = 0,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    -- Signature setup
                    local signature_ok, signature = pcall(require, 'lsp_signature')
                    if signature_ok then
                        signature.on_attach({
                            bind = true,
                            handlers_opts = {
                                border = "rounded"
                            }
                        }, bufnr)
                    end
                end
            }
            return ret
        end,
        config = function(_, opts)
            local lspconf = require("lspconfig")
            -- Merge lsp defaults with global configuration
            lspconf.util.default_config = vim.tbl_deep_extend(
                'force',
                lspconf.util.default_config,
                opts
            )

            -- Hover customization
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )

            -- Signature help customization
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = 'rounded' }
            )

            -- Diagnostic customization
            for severity, icon in pairs(opts.diagnostics.signs.text) do
                local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        end,
    },

    -- Manage external editors
    -- https://github.com/mason-org/mason.nvim
    {
        'mason-org/mason.nvim',
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ui = {
                check_outdated_packages_on_open = true,
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
                keymaps = {
                    toggle_package_expand = "<CR>",
                    install_package = "i",
                    update_package = "u",
                    check_package_version = "c",
                    update_all_packages = "U",
                    check_outdated_packages = "C",
                    uninstall_package = "X",
                    cancel_installation = "<C-c>",
                    apply_language_filter = "<C-f>",
                },
            },
            max_concurrent_installers = 4,
            github = {
                download_url_template = "https://github.com/%s/releases/download/%s/%s",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },

    -- Bridge mason with lspconfig
    -- https://github.com/williamboman/mason-lspconfig.nvim
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {},
            automatic_installation = true,
        },
        config = function(_, opts)
            local mlsp = require("mason-lspconfig")
            local lspconf = require("lspconfig")
            mlsp.setup(opts)
        end,
    },

    -- Diagnostic and code injection
    -- https://github.com/nvimtools/none-ls.nvim
    {
        'https://github.com/nvimtools/none-ls.nvim',
        config = function()
            local null_ok, null = pcall(require, "null-ls")
            if not null_ok then
                return
            end

            local frmt = null.builtins.formatting
            local diag = null.builtins.diagnostics

            null.setup({
                debounce = 250,
                debug = false,
                default_timeout = 5000,
                notify_format = "[null-ls] %s",
                update_in_insert = false,
                sources = {
                    -- formatter
                    frmt.shfmt.with({
                        filetypes = { "sh" },
                        extra_args = { "--indent", 4 },
                    }),

                    frmt.stylua.with({
                        filetypes = { "lua" },
                        extra_args = { "--indent-type", "Spaces" },
                    }),

                    frmt.black.with({
                        filetypes = { "python" },
                    }),

                    frmt.goimports.with({
                        filetypes = { "go" },
                    }),

                    frmt.prettier.with({
                        filetypes = { "json", "yaml", "markdown" },
                    }),

                    -- linter
                    --diag.shellcheck.with({
                    --    filetypes = { "sh" },
                    --    diagnostic_config = { underline = false },
                    --}),

                    diag.selene.with({
                        filetypes = { "lua" },
                    }),

                    --diag.flake8.with({
                    --    filetypes = { "python" },
                    --}),

                    diag.golangci_lint.with({
                        filetypes = { "go" },
                    }),
                },
            })
        end,
    },

    -- Debug adapter protocol
    -- https://github.com/mfussenegger/nvim-dap
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.fn.sign_define(
                "DapBreakpoint", {
                    text = "",
                    texthl = "DiagnosticSignError",
                    linehl = "",
                    numhl = ""
                })
        end,
    },

    -- Dap ui
    -- https://github.com/rcarriga/nvim-dap-ui
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'nvim-neotest/nvim-nio'
        },
        opts = {
            layouts = {
                {
                    elements = {
                        'scopes',
                        'breakpoints',
                        'stacks',
                        'watches',
                    },
                    size = 40,
                    position = 'left',
                },
                {
                    elements = {
                        'repl',
                        'console',
                    },
                    size = 10,
                    position = 'bottom',
                },
            },
        },
        config = function(_, opts)
            local dapui = require("dapui")
            local dap = require("dap")
            dapui.setup(opts)

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    -- Virtual text support
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },

    -- 'ravenxrz/DAPInstall.nvim',                   -- Dap installer
}

-- vim: ts=4 sts=4 sw=4 et
