-- Init
-- stylua: ignore
--if true then return {} end

-- Init lazyvim
require("lazyvim.config").init()

-- Yank to clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Terminal Mappings
local function term_nav(dir)
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

-- Snacks picker setup
if lazyvim_docs then
	vim.g.lazyvim_picker = "snacks"
end

local picker = {
	name = "snacks",
	commands = {
		files = "files",
		live_grep = "grep",
		oldfiles = "recent",
	},

	open = function(source, opts)
		return Snacks.picker.pick(source, opts)
	end,
}
if not LazyVim.pick.register(picker) then
	return {}
end

return {
	-- A collection of small QoL plugins
	-- https://github.com/folke/snacks.nvim
	{ "snacks.nvim", opts = {} },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
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
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>dps",
				function()
					Snacks.profiler.scratch()
				end,
				desc = "Profiler Scratch Buffer",
			},
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

	-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
							["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
						},
					},
				},
				actions = {
					toggle_cwd = function(p)
						local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
						local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
						local current = p:cwd()
						p:set_cwd(current == root and cwd or root)
						p:find()
					end,
				},
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
            { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
            { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
            { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
            { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
            { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            -- git
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            -- grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
            { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
            { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
            { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
            -- search
            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
            -- ui
            { "<leader>uC",
                function()
                    Snacks.picker.colorschemes(
                        {
                            finder = "vim_colorschemes",
                            format = "text",
                            preview = "colorscheme",
                            preset = "vertical",
                            confirm = function(pick, item)
                                pick:close()
                                if item then
                                    pick.preview.state.colorscheme = nil
                                    vim.schedule(function()
                                        vim.cmd("colorscheme " .. item.text)
                                    end)
                                end
                            end,
                        }
                    )
                end,
                desc = "Colorschemes" },
        },
	},
}

-- vim: ts=4 sts=4 sw=4 et
