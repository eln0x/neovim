-- Neovim UI
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --
    --
    -- 🥪 Snacks UI helpers
    -- https://github.com/folke/snacks.nvim
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = { enabled = false },        -- alpha
            scroll = { enabled = false },           -- use comfortable-motion instead
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --

    -- 🌀 Smooth scrolling
    -- https://github.com/yuttie/comfortable-motion.vim
    {
        'yuttie/comfortable-motion.vim',
    },
}

-- vim: ts=4 sts=4 sw=4 et
