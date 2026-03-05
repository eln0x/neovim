-- Neovim Ai
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- INFO: LazyVim extra --

    -- 🤖 Copilot: AI pair programmer (inline suggestions)
    -- https://github.com/zbirenbaum/copilot.lua
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = false,
                hide_during_completion = true,
                auto_trigger = false,
                keymap = {
                    accept = false,
                    next = "<C-n>",
                    prev = "<C-p>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                lua = true,
                sh = true,
                python = true,
                go = true,
                markdown = true,
                yaml = true,
                json = true,
                text = true,
                help = true,
                ["*"] = false,
            },
        },
    },

    -- 🖥️ LSP Core: Language server protocol setup
    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- copilot.lua only works with its own copilot lsp server
            servers = {
                copilot = { enabled = false },
            },
        },
    },

    -- 🤖 AI chat assistant for Neovim
    -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cmd = "CopilotChat",
        opts = function()
            local user = vim.env.USER or "User"
            user = user:sub(1, 1):upper() .. user:sub(2)
            return {
                auto_insert_mode = true,
                headers = {
                    user = "  " .. user .. " ",
                    assistant = "  Copilot ",
                    tool = "󰊳  Tool ",
                },
                window = {
                    width = 0.4,
                },
            }
        end,
        keys = {
            { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
            { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
            {
                "<leader>aa",
                function()
                    return require("CopilotChat").toggle()
                end,
                desc = "Toggle (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>ax",
                function()
                    return require("CopilotChat").reset()
                end,
                desc = "Clear (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>aq",
                function()
                    vim.ui.input({
                        prompt = "Quick Chat: ",
                    }, function(input)
                            if input ~= "" then
                                require("CopilotChat").ask(input)
                            end
                        end)
                end,
                desc = "Quick Chat (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>ap",
                function()
                    require("CopilotChat").select_prompt()
                end,
                desc = "Prompt Actions (CopilotChat)",
                mode = { "n", "x" },
            },
            {
                "<leader>am",
                function()
                    require("CopilotChat").select_model()
                end,
                desc = "Select Model (CopilotChat)",
                mode = { "n", "x" },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")

            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-chat",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                end,
            })

            chat.setup(opts)
        end,
    },

    -- 📝 Markdown Rendering: Enhanced markdown UI (copilot-chat support)
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "copilot-chat" },
        },
        ft = { "markdown", "copilot-chat" },
    },

    -- ⚡ Completion: Copilot
    -- https://github.com/giuxtaposition/blink-cmp-copilot
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "giuxtaposition/blink-cmp-copilot",
            },
        },
        opts = {
            sources = {
                default = { "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    path = {
                        -- Path sources triggered by "/" interfere with CopilotChat commands
                        enabled = function()
                            return vim.bo.filetype ~= "copilot-chat"
                        end,
                    },
                },
            },
        },
    },

    -- TEST: External plugins --

}

-- vim: ts=4 sts=4 sw=4 et
