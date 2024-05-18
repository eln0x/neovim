-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local vim = vim
local setkey = vim.keymap.set
local opts = { silent = true }

-- Remap space as leader key
setkey("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

--
-- Normal_mode = "n",
--

-- Copy whole file
setkey("n", "<C-c>", "<cmd> %y+ <cr>", opts)

-- Move text up and down
setkey("n", "<A-k>", "<Esc>:m .-2<cr>==gi", opts)
setkey("n", "<A-j>", "<Esc>:m .+1<cr>==gi", opts)

-- Navigate line
setkey("n", "<C-a>", "^", opts)
setkey("n", "<C-e>", "$", opts)

-- Navigate tabs
setkey("n", "<C-t>", "<cmd>tabnew<cr>", opts)
setkey("n", "<C-PageDown>", "<cmd>tabprev<cr>", opts)
setkey("n", "<C-PageUp>", "<cmd>tabnext<cr>", opts)

-- Navigate windows
setkey("n", "<C-w><Up>", "<cmd>wincmd k<cr>")
setkey("n", "<C-w><Down>", "<cmd>wincmd j<cr>")
setkey("n", "<C-w><Right>", "<cmd>wincmd l<cr>")
setkey("n", "<C-w><Left>", "<cmd>wincmd h<cr>")
setkey("n", "<leader>!", "<cmd>vsplit<cr>")

-- Navigate buffers
setkey("n", "<leader>n", "<cmd>enew<cr>", opts)
setkey("n", "<leader><Right>", "<cmd>bnext<cr>", opts)
setkey("n", "<leader><Left>", "<cmd>bprev<cr>", opts)

-- Toggles
setkey("n", "<F1>", "<cmd>Alpha<cr>", opts)
setkey("n", "<F2>", "<cmd>NvimTreeToggl<cr>", opts)
setkey("n", "<F3>", "<cmd>TagbarToggle<cr>", opts)
setkey("n", "<F4>", "<cmd>AerialToggle<cr>", opts)
setkey("n", "<F5>", "<cmd>Mason<cr>", opts)
setkey("n", "<F6>", "<cmd>NullLsInfo<cr>", opts)

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
setkey('n', '<C-Down>', '<cmd>call comfortable_motion#flick(100)<cr>', opts)
setkey('n', '<C-Up>', '<cmd>call comfortable_motion#flick(-100)<cr>', opts)
setkey('n', '<C-f>', '<cmd>call comfortable_motion#flick(200)<cr>', opts)
setkey('n', '<C-b>', '<cmd>call comfortable_motion#flick(-200)<cr>', opts)


--
-- Visual_mode = "v",
--

-- Move text up and down
setkey("v", "<A-j>", ":m .+1<cr>==", opts)
setkey("v", "<A-k>", ":m .-2<cr>==", opts)

--
-- Visual_block_mode = "x",
--

-- Move text up and down
setkey("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
setkey("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

-- Insert_mode = "i",
-- Term_mode = "t",
-- Command_mode = "c",

-- vim: ts=4 sts=4 sw=4 et
