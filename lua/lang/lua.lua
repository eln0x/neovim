-- Neovim Lua
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "lua" },
            root = ".git",
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "lua", "luadoc", "luap" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "lua-language-server",  -- language server protocol
                "stylua",               -- formatter
                "luacheck",             -- linter
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
                lua = { "luacheck" },
            },
            linters = {
                luacheck = {
                    cmd = "luacheck",
                    args = { "--formatter=plain", "--codes", "--ranges", "-" },
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
                lua = { "stylua" },
            },
            formatters = {
                stylua = {
                    command = "stylua",
                    args = { "--indent-type", "Spaces", "--indent-width", "4", "-" },
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
                nls.builtins.formatting.stylua,
            })
        end,
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }, -- recognize `vim` global
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
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
                            telemetry = {
                                enable = false
                            },
                        },
                    },
                },
            },
        },
    },
    -- 🌍 Icons for Lua-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                lua = { glyph = "", hl = "MiniIconsBlue" },
                luadoc = { glyph = "󰢱", hl = "MiniIconsGrey" },
            },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
