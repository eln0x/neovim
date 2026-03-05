-- Neovim Dap
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🐞 Provides debugging support for multiple languages
    -- https://github.com/mfussenegger/nvim-dap
    {
        "mfussenegger/nvim-dap",
        recommended = true,
        desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            -- virtual text for the debugger
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
        },

        -- stylua: ignore
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },
    },

    -- 🖥️ Fancy UI for nvim-dap, with widgets and REPL
    -- https://github.com/rcarriga/nvim-dap-ui
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
            { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
        },
        opts = {},
    },

    -- 🔧 Automatically install & configure DAP adapters
    -- https://github.com/jay-babu/mason-nvim-dap.nvim
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
            },
        },
    },


    -- INFO: LazyVim extra --

    -- TEST: External plugins --

}

-- vim: ts=4 sts=4 sw=4 et
