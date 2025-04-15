-- Init
-- stylua: ignore
--if true then return {} end

require("lazyvim.config").init()

return {

	{ "folk/lazy.nvim", version = "*" },

	-- A collection of small QoL plugins
	-- https://github.com/folke/snacks.nvim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = { enabled = false },
		},
		config = function(_, opts)
			local notify = vim.notify
			require("snacks").setup(opts)
			-- HACK: restore vim.notify after snacks setup and let noice.nvim take over
			-- this is needed to have early notifications show up in noice history
			if LazyVim.has("noice.nvim") then
				vim.notify = notify
			end
		end,
	},
}

-- vim: ts=4 sts=4 sw=4 et
