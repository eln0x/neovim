-- Neovim New
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "markdown", "markdown.mdx" },
            root = { ".git", ".markdownlint.json", ".markdownlint-cli2.jsonc" }
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "markdown", "markdown_inline" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "marksman",                     -- language server protocol
                "prettier", "markdown-toc",     -- formatter
                "markdownlint-cli2"             -- linter
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
                markdown = { "markdownlint-cli2" },
            },
            linters = {
                markdownlint_cli2 = {
                    cmd = "markdownlint-cli2",
                    args = { "--stdin" },
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
                markdown = { "injected", "prettier", "markdownlint-cli2", "markdown-toc" },
            },
            formatters = {
                ["prettier"] = {
                    args = {
                        "--stdin-filepath",
                        "$FILENAME",
                    },
                },
                ["markdown-toc"] = {
                    condition = function(_, ctx)
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                            if line:find("<!%-%- toc %-%->") then
                                return true
                            end
                        end
                    end,
                },
                ["markdownlint-cli2"] = {
                    condition = function(_, ctx)
                        local diag = vim.tbl_filter(function(d)
                            return d.source == "markdownlint"
                        end, vim.diagnostic.get(ctx.buf))
                        return #diag > 0
                    end,
                },
            },
        },
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                marksman = {
                    cmd = { "marksman" },
                    filetypes = { "markdown" },
                    settings = {
                        marksman = {
                            diagnostics = {
                                validate = true,
                                suppressed = {
                                    "MD013", -- line length
                                    "MD033", -- inline HTML
                                },
                            },
                            completions = {
                                enabled = true,
                            },
                            links = {
                                validate = true,
                                followExternal = true,
                            },
                            formatting = {
                                trimTrailingWhitespace = true,
                                trimFinalNewlines = true,
                            },
                        },
                    },
                },
            },
        },
    },
    -- 🌍 Icons for Markdown-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                markdown = { glyph = "", hl = "MiniIconsBlue" },
            },
        },
    },
    -- 🪶 Markdown Preview (browser)
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        keys = {
            {
                "<leader>cp",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown Preview",
            },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    -- 🖋️ Render Markdown (inline)
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = {},
            },
            checkbox = {
                enabled = false,
            },
        },
        ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            Snacks.toggle({
                name = "Render Markdown",
                get = require("render-markdown").get,
                set = require("render-markdown").set,
            }):map("<leader>um")
        end,
    },
}

-- vim: ts=4 sts=4 sw=4 et
