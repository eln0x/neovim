-- Neovim Util
-- stylua: ignore
--if true then return {} end

-- Terminal Mappings
local function term_nav(dir)
    ---@param self snacks.terminal
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
            vim.cmd.wincmd(dir)
        end)
    end
end

return {

	-- INFO: LazyVim default --

	-- Snacks utils
	{
		"snacks.nvim",
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			terminal = {
				win = {
					keys = {
						nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
						nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
						nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
						nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
					},
				},
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
        },
	},

	-- Automated session management
	-- https://github.com/folke/persistence.nvim
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/session/"),
			options = {
				"buffers",
				"curdir",
				"tabpages",
				"winsize",
			},
		},
		config = function(_, opts)
			require("persistence").setup(opts)
		end,
	},

	-- Library used by other plugins
	-- https://github.com/nvim-lua/plenary.nvim
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},

	-- INFO: LazyVim extra --

	-- Project jumper
	-- https://github.com/ahmedkhalf/project.nvim
	{
		"ahmedkhalf/project.nvim",
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

	-- TEST: External plugins --

	-- HAProxy syntax
	-- https://github.com/Joorem/vim-haproxy
	{
		"Joorem/vim-haproxy",
	},
}

-- vim: ts=4 sts=4 sw=4 et
