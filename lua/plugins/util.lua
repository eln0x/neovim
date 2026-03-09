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

    -- INFO: LazyVim extra --

    -- 🏃 Project jumper
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
	},

    -- TEST: External plugins --

    -- 🖥 HAProxy syntax highlighting
    -- https://github.com/Joorem/vim-haproxy
    {
        'Joorem/vim-haproxy',
    },
}

-- vim: ts=4 sts=4 sw=4 et
