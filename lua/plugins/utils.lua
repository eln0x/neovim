-- Utils
-- stylua: ignore
--if true then return {} end

return {
    -- Project jumper
    -- https://github.com/ahmedkhalf/project.nvim
    {
        'ahmedkhalf/project.nvim',
        opts = {
            active = true,
            detection_methods = { "pattern" },
            patterns = { ".git", "Makefile", "package.json" },
            show_hidden = false,
            silent_chdir = true,
            datapath = vim.fn.stdpath("data"),
        },
        config = function(_, opts)
          require("project_nvim").setup(opts)
        end,
    },

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
