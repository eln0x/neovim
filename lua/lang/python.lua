-- Neovim Python
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = "python",
            root = {
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json",
            },
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "python", "ninja", "rst" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "basedpyright",         -- language server protocol
                "black",                -- formatter
                "ruff", "mypy",         -- linter
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
                python = { "ruff", "mypy" },
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {
                ruff = {
                    cmd = "ruff",
                    args = { "check", "--quiet", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                },
                mypy = {
                    cmd = "mypy",
                    args = { "--show-column-numbers", "--ignore-missing-imports", "--no-color-output" },
                    stdin = false,
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
                python = { "ruff_fix", "black" },
            },
            formatters = {
                ruff_fix = {
                    command = "ruff",
                    args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                },
            },
        }
    },
    -- 🪄 None-ls: Formatters & Linters via LSP.
    {
        "nvimtools/none-ls.nvim",
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
                nls.builtins.formatting.isort,
                nls.builtins.code_actions.refactoring,
            })
        end,
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                basedpyright = {
                    settings = {
                        basedpyright = {
                            disableOrganizeImports = true, -- let Ruff handle it
                            analysis = {
                                typeCheckingMode = "basic", -- 'off', 'basic', 'strict'
                                autoImportCompletions = true,
                                diagnosticMode = "workspace", -- analyze all files
                                useLibraryCodeForTypes = true,
                                autoSearchPaths = true,
                            },
                        },
                    },
                },
                ruff = {
                    cmd_env = { RUFF_TRACE = "messages" },
                    init_options = {
                        settings = {
                            logLevel = "error",
                        },
                    },
                    keys = {
                        {
                            "<leader>co",
                            LazyVim.lsp.action["source.organizeImports"],
                            desc = "Organize Imports",
                        },
                    },
                },
            },
        },
    },
    -- 🌍 Icons for Python-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                python = { glyph = "", hl = "MiniIconsYellow" },
                py = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
    },
    -- 🐍 Virtual Environment Manager: venv-selector
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        opts = {
            options = {
                notify_user_on_venv_activation = true,
            },
        },
        --  Call config for Python files and load the cached venv automatically
        ft = "python",
        keys = {
            { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" }
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
