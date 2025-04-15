-- Neovim Completion
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- ⚡ Autocompletion engine
    -- https://github.com/saghen/blink.cmp
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = vim.g.ai_cmp,
                },
            },
            signature = { enabled = true },
            sources = {
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
                compat = {},
                default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = "cmdline",
                    ["<Right>"] = false,
                    ["<Left>"] = false,
                    -- Easy navigation
                    ["<Tab>"] = { "select_next" },
                    ["<S-Tab>"] = { "select_prev" },
                    ["<C-p>"] = { "select_prev" },
                    ["<C-n>"] = { "select_next" },
                    ["<C-Up>"] = { "select_prev" },
                    ["<C-Down>"] = { "select_next" },
                    -- Accept & cancel
                    ["<C-Right>"] = { "accept" },
                    --["<Esc>"] = { "cancel" },
                },
            },
            keymap = {
                preset = "enter",
                ["<C-y>"] = { "select_and_accept" },
                ["<Tab>"] = { "select_and_accept", "fallback" },
                ["<C-Down>"] = { "scroll_documentation_down" },
                ["<C-Up>"] = { "scroll_documentation_up" },
                ["<Esc>"] = { "cancel", "fallback" },
            },
        },
    },

    -- 🖥️ LazyDev completion
    -- https://github.com/folke/lazydev.nvim
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                -- add lazydev to your completion providers
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },

    -- 📦 Collection of code snippets
    -- https://github.com/rafamadriz/friendly-snippets
    {
        "rafamadriz/friendly-snippets",
    },

    -- 🎨 Theme integration: catppuccin - Blink completion styling
    -- https://github.com/catppuccin
    {
        "catppuccin",
        opts = {
            integrations = { blink_cmp = true },
        },
    }

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

}

-- vim: ts=4 sts=4 sw=4 et
