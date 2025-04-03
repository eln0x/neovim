-- Neovim Util
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- Automated session management
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

    -- Library used by other plugins
    -- https://github.com/nvim-lua/plenary.nvim
    {
        'nvim-lua/plenary.nvim',
    },

    -- INFO: LazyVim extra --

	-- Project jumper
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

	-- Startup time bench
	-- https://github.com/dstein64/vim-startuptime
	{
		"dstein64/vim-startuptime",
        enabled = true,
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

    -- TEST: External plugins --

    -- HAProxy syntax
    -- https://github.com/Joorem/vim-haproxy
    {
        'Joorem/vim-haproxy',
    },
}

-- vim: ts=4 sts=4 sw=4 et
