-- Neovim Bash
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = {
                "sh",
                "bash",
                "zsh"
            },
            root = ".git",
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "bash", "make" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "bash-language-server", -- language server protocol
                "shfmt",                -- formatter
                "shellcheck",           -- linter
                "bash-debug-adapter",   -- debugger
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
                sh = { "shellcheck" },
                bash = { "shellcheck" },
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {
                shellcheck = {
                    cmd = "shellcheck",
                    args = { "--format=gcc", "-" },
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
                sh = { "shfmt" },
                bash = { "shellcheck" },
            },
            formatters = {
                shfmt = {
                    command = "shfmt",
                    args = { "-i", "4", "-ci", "-bn", "-sr" },
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
                nls.builtins.formatting.shfmt,
            })
        end,
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                bashls = {
                    cmd = { "bash-language-server", "start" },
                    filetypes = { "sh", "bash", "zsh" },
                    settings = {
                        bashIde = {
                            globPattern = "**/*@(.sh|.inc|.bash)",
                            checkShell = "bash",
                        },
                    },
                },
            },
        },
    },
    -- 🐞 DAP for Bash
    {
        "mfussenegger/nvim-dap",
        ft = { "sh", "bash" },
        config = function()
            local dap = require("dap")
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter"

            dap.adapters.sh = {
                type = "executable",
                command = mason_path .. '/bash-debug-adapter',
                name = 'bashdb',
            }
            dap.adapters.bash = dap.adapters.sh

            dap.configurations.sh = {
                {
                    type = 'sh',
                    request = 'launch',
                    name = "Launch file",
                    showDebugOutput = true,
                    pathBashdb = mason_path .. '/extension/bashdb_dir/bashdb',
                    pathBashdbLib = mason_path .. '/extension/bashdb_dir',
                    trace = true,
                    file = "${file}",
                    program = "${file}",
                    cwd = '${workspaceFolder}',
                    pathCat = "cat",
                    pathBash = "/bin/bash",
                    pathMkfifo = "mkfifo",
                    pathPkill = "pkill",
                    args = {},
                    argsString = '',
                    env = {},
                    terminalKind = "integrated",
                }
            }

            dap.configurations.bash = dap.configurations.sh
        end,
    },
    -- 🌍 Icons for Bash-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                sh = { glyph = "", hl = "MiniIconsGreen" },
                bash = { glyph = "", hl = "MiniIconsGreen" },
                zsh = { glyph = "", hl = "MiniIconsBlue" },
            },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
