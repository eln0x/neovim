-- Neovim Yoda
-- stylua: ignore
--if true then return {} end

return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/yoda",
        name = "yoda",
        keys = {
            -- Kulala
            {
                "<leader>rl",
                function() require("yoda").apis() end,
                desc = "List requests"
            },
            -- Browse
            {
                "<leader>zt",
                function() require("yoda").todos() end,
                desc = "Todos",
            },
            {
                "<leader>zr",
                function() require("yoda").runs() end,
                desc = "Runs",
            },
            {
                "<leader>zn",
                function() require("yoda").notes() end,
                desc = "Notes",
            },

            -- Create
            {
                "<leader>zT",
                function() require("yoda").new_todo() end,
                desc = "New Todo",
            },
            {
                "<leader>zR",
                function() require("yoda").new_run() end,
                desc = "New Run",
            },
            {
                "<leader>zN",
                function() require("yoda").new_note() end,
                desc = "New Note",
            },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    "<leader>z",
                    group = "Reference",
                    icon = { icon = "󰂺", color = "red" },
                },
            },
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, "YodaRestApi", {
                link = "WhichKeyGroup",
                underline = false,
            })

            require("which-key").setup(opts)
        end,
    },
}
