-- Neovim Util
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 💾 Automated session management
    -- https://github.com/folke/persistence.nvim
    {
        "folke/persistence.nvim",
        enabled = true,
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
            options = {
                "buffers",
                "curdir",
                "tabpages",
                "winsize"
            },
        },
    },

    -- 📚 Library used by other plugins
    -- https://github.com/nvim-lua/plenary.nvim
    {
        'nvim-lua/plenary.nvim',
    },

    -- INFO: LazyVim extra --

    -- 🏃 Project jumper
	-- https://github.com/ahmedkhalf/project.nvim
	{
		"ahmedkhalf/project.nvim",
        enabled = true,
		opts = {
			active = true,
			detection_methods = { "pattern" },
			patterns = { ".git", "Makefile", "package.json" },
			show_hidden = false,
			silent_chdir = true,
			datapath = vim.fn.stdpath("data"),
		},
	},

    -- 🌐 REST client for HTTP requests
    -- https://github.com/mistweaverco/kulala.nvim
    {
        "mistweaverco/kulala.nvim",
        ft = "http",
        keys = {
            { "<leader>r", "", desc = "Rest" },
            { "<leader>rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
            { "<leader>rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
            { "<leader>rC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
            { "<leader>re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment", ft = "http" },
            { "<leader>rg", "<cmd>lua require('kulala').download_graphql_schema()<cr>", desc = "GraphQL schema", ft = "http" },
            { "<leader>rl", function() require("library.kulala").open() end, desc = "List requests", },
            { "<leader>ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", ft = "http" },
            { "<leader>rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
            { "<leader>rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", ft = "http" },
            { "<leader>rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
            { "<leader>rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
            { "<leader>rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http" },
            { "<leader>rS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = "http" },
            { "<leader>rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", ft = "http" },
        },
        opts = {
            additional_curl_options = { "--insecure" },
        },
    },

    -- ⏱  Startup time benchmark
	-- https://github.com/dstein64/vim-startuptime
	{
		"dstein64/vim-startuptime",
        enabled = true,
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

    -- TEST: External plugins --

    -- 🖥 HAProxy syntax highlighting
    -- https://github.com/Joorem/vim-haproxy
    {
        'Joorem/vim-haproxy',
    },
}

-- vim: ts=4 sts=4 sw=4 et
