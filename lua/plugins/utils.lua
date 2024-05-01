-- Utils
-- stylua: ignore
--if true then return {} end

return {
    -- Startup time bench
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- Automated session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
    },

    -- Library used by other plugins
    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },

}
