-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local del = vim.keymap.del

-- Remap space as leader key
set("", "<Space>", "<Nop>", { silent = true } )
vim.g.mapleader = " "

-- Toggles
set("n", "<F2>", "<cmd>Alpha<cr>", { silent = true })
set("n", "<F3>", "<cmd>Mason<cr>", { silent = true })
set("n", "<F4>", "<cmd>LspInfo<cr>", { silent = true })
set("n", "<F5>", "<cmd>NullLsInfo<cr>", { silent = true })

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
set("n", "<C-Down>", "<cmd>call comfortable_motion#flick(100)<cr>", { desc = "Scroll Down", silent = true })
set("n", "<C-Up>", "<cmd>call comfortable_motion#flick(-100)<cr>", { desc = "Scroll Up", silent = true })

-- Navigate windows
set("n", "<C-w><Up>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", remap = true })
set("n", "<C-w><Down>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", remap = true })
set("n", "<C-w><Right>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", remap = true })
set("n", "<C-w><Left>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", remap = true })

-- Navigate tabs
set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
set("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Navigate buffers
set("n", "<leader><Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "<leader><Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File", silent = true } )

-- Copy whole file
set("n", "<C-c>", "<cmd> %y+ <cr>", { silent = true })

-- Save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- vim: ts=4 sts=4 sw=4 et
