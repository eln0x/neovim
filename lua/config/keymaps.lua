-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", { silent = true } )
vim.g.mapleader = " "

--
-- Normal_mode = "n",
--

-- Toggles
map("n", "<F2>", "<cmd>Alpha<cr>", { silent = true } )
map("n", "<F3>", "<cmd>Mason<cr>", { silent = true } )
map("n", "<F4>", "<cmd>NullLsInfo<cr>", { silent = true } )

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
map('n', '<C-Down>', '<cmd>call comfortable_motion#flick(100)<cr>', { desc = "Scroll Down", silent = true } )
map('n', '<C-Up>', '<cmd>call comfortable_motion#flick(-100)<cr>', { desc = "Scroll Up", silent = true } )

-- Navigate windows
map("n", "<C-w><Up>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", remap = true } )
map("n", "<C-w><Down>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", remap = true } )
map("n", "<C-w><Right>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", remap = true } )
map("n", "<C-w><Left>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", remap = true } )

-- Navigate tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Navigate buffers
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File", silent = true } )
map("n", "<leader><Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader><Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- Copy whole file
map("n", "<C-c>", "<cmd> %y+ <cr>", { silent = true } )

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Visual_mode = "v",
-- Visual_block_mode = "x",
-- Insert_mode = "i",
-- Term_mode = "t",
-- Command_mode = "c",

-- vim: ts=4 sts=4 sw=4 et
