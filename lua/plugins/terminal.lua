-- Neovim Terminal
-- stylua: ignore
--if true then return {} end

return {
    -- 🖥️ Toggle terminal integration
    -- https://github.com/akinsho/toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = false,
            shell = vim.o.shell,
            float_opts = { border = "curved" },
        },
        keys = {
            {
                "<leader>tb",
                "<cmd>ToggleTerm size=30 direction=horizontal<cr>",
                desc = "Bottom",
            },
            {
                "<leader>tr",
                "<cmd>ToggleTerm size=80 direction=vertical<cr>",
                desc = "Right",
            },
            {
                "<leader>tf",
                "<cmd>ToggleTerm direction=float<cr>",
                desc = "Float",
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
        end,
    },

    -- 🖥️ Snacks terminal integration
    {
        "folke/snacks.nvim",
        opts = {
            terminal = {
                win = {
                    position = "bottom",
                    border = "rounded",
                },
            },
        },
        keys = {
            {
                "<leader>th",
                function()
                    _G.snacks_terminal_toggle("htop", "htop", {
                        win = { position = "float", height = 0.65 },
                    })
                end,
                desc = "Htop",
            },
            {
                "<leader>tg",
                function()
                    _G.snacks_terminal_toggle("lazygit", "lazygit", {
                        win = { position = "float", height = 0.85 },
                    })
                end,
                desc = "Lazygit",
            },
        },
        config = function(_, opts)
            local Snacks = require("snacks")
            Snacks.setup(opts)

            -- persistent terminal manager
            local terminals = {}
            _G.snacks_terminal_toggle = function(name, cmd, myopts)
                opts = myopts or {}
                if not terminals[name] then
                    terminals[name] = Snacks.terminal(cmd, opts)
                else
                    terminals[name]:toggle()
                end
            end
        end,
    },
}
-- vim: ts=4 sts=4 sw=4 et
