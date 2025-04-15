-- Neovim Treesitter
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🌳 Syntax highlighting & parsing
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "awk",
                "c",
                "comment",
                "diff",
                "dockerfile",
                "helm",
                "html",
                "javascript",
                "jsdoc",
                "latex",
                "perl",
                "printf",
                "puppet",
                "regex",
                "rust",
                "sql",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
            },
        },
    },

    -- 🧩 Text objects powered by Treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = true,
        opts = {},
    },

    -- 🔖 Auto-close tags for HTML/JSX
    -- https://github.com/windwp/nvim-ts-autotag
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        event = "LazyFile",
        opts = {},
    },

    -- INFO: LazyVim extra --

    -- 📜 Show current function/block context
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "LazyFile",
        opts = function()
            local tsc = require("treesitter-context")
            Snacks.toggle({
                name = "Treesitter Context",
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            }):map("<leader>ut")
            return { mode = "cursor", max_lines = 3 }
        end,
    },

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
