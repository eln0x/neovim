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
    -- https://github.com/dstein64/vim-startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- Automated session management
    -- https://github.com/folke/persistence.nvim
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
            options = {
                "buffers",
                "curdir",
                "tabpages",
                "winsize"
            },
        },
        config = function(_, opts)
            require("persistence").setup(opts)
        end,
    },

    -- Library used by other plugins
    -- https://github.com/nvim-lua/plenary.nvim
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },

    -- Speedup startup time
    -- https://github.com/lewis6991/impatient.nvim
    {
        'lewis6991/impatient.nvim',
        opts = { },
        config = function(_, opts)
            require("impatient").enable_profile()
        end,
    },

}

-- vim: ts=4 sts=4 sw=4 et
