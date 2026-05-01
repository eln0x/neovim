-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local vim = vim

-- Create augroup function
local function augroup(name)
	return vim.api.nvim_create_augroup("draknet_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_del_augroup_by_name("lazyvim_highlight_yank")
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank({
			--higroup = "Visual",
			timeout = 200,
		})
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_del_augroup_by_name("lazyvim_close_with_q")
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
        "dap-float",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- Remove trailing white spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Set js tab config
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

-- Always open files with folds closed
--vim.api.nvim_create_autocmd("BufReadPost", {
--    pattern = "*",
--    callback = function()
--        vim.cmd("normal! zM")
--    end,
--})

-- vim: ts=4 sts=4 sw=4 et
