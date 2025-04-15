-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local del = vim.keymap.del

-- Toggles
set("n", "<F2>", "<cmd>Alpha<cr>", { silent = true })
set("n", "<F3>", "<cmd>Mason<cr>", { silent = true })
set("n", "<F4>", "<cmd>LspInfo<cr>", { silent = true })
set("n", "<F5>", "<cmd>NullLsInfo<cr>", { silent = true })
set("n", "<F6>", "<cmd>HuezFavorites<cr>", { silent = true })

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
del("n", "<leader>uS")
del("n", "<C-Down>")
set("n", "<C-Down>", "<cmd>call comfortable_motion#flick(100)<cr>", { desc = "Scroll Down", silent = true })
del("n", "<C-Up>")
set("n", "<C-Up>", "<cmd>call comfortable_motion#flick(-100)<cr>", { desc = "Scroll Up", silent = true })

-- Split windows
del("n", "<leader>-")
set("n", "<leader>§", "<C-W>s", { desc = "Split Window Below", remap = true })
del("n", "<leader>|")
set("n", "<leader>!", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Navigate windows
set("n", "<C-w><Up>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", remap = true })
set("n", "<C-w><Down>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", remap = true })
set("n", "<C-w><Right>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", remap = true })
set("n", "<C-w><Left>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", remap = true })

-- Navigate buffers
set("n", "<leader><Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "<leader><Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<leader>$", "<cmd>bdelete<cr>", { desc = "Del Buffer" })

-- Copy whole file
set("n", "<C-c>", "<cmd> %y+ <cr>", { silent = true })
set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

-- Save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Open explorer, symbols and diagnostics
set("n", "<leader>ux", function()
    local snacks = require("snacks")

    if vim.bo.filetype == "lazy" or vim.bo.filetype == "alpha" then
        return
    end
    -- open explorer
    snacks.explorer({ cwd = LazyVim.root() })

    -- toggle Trouble panels safely
    vim.cmd("Trouble symbols toggle")
    vim.cmd("Trouble diagnostics toggle")
end, { desc = "Toggle Dev UI" })

-- vim: ts=7 sts=4 sw=4 et
