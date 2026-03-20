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
            { "<leader>R", "", desc = "+Rest" },
            { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
            { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
            { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
            { "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment", ft = "http" },
            {
                "<leader>Rg",
                "<cmd>lua require('kulala').download_graphql_schema()<cr>",
                desc = "Download GraphQL schema",
                ft = "http",
            },
            { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", ft = "http" },
            { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
            { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", ft = "http" },
            { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
            { "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
            { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http" },
            { "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = "http" },
            { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", ft = "http" },
        },
        opts = {},
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
