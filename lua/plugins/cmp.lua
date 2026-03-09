-- Neovim Completion
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- ⚡ Autocompletion engine
    -- https://github.com/saghen/blink.cmp
    {
        "saghen/blink.cmp",
        opts = {
            signature = { enabled = true },
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

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
