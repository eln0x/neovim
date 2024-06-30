-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local vim = vim
local delkey = vim.keymap.del
local map = vim.keymap.set
local opts = { silent = true }

-- Remap space as leader key
vim.g.mapleader = " "

--
-- Normal_mode = "n",
--

-- Delete LazyVim keymaps
delkey("n", "<leader>|", opts)
delkey("n", "<leader>-", opts)

-- Toggles
map("n", "<F1>", "<cmd>Alpha<cr>", opts)
map("n", "<F2>", "<cmd>NvimTreeToggl<cr>", opts)
map("n", "<F3>", "<cmd>AerialToggle<cr>", opts)
map("n", "<F4>", "<cmd>Mason<cr>", opts)
map("n", "<F5>", "<cmd>NullLsInfo<cr>", opts)

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
map('n', '<C-Down>', '<cmd>call comfortable_motion#flick(100)<cr>', { desc = "Scroll Down", silent = true } )
map('n', '<C-Up>', '<cmd>call comfortable_motion#flick(-100)<cr>', { desc = "Scroll Up", silent = true } )

-- Navigate windows
map("n", "<C-w><Up>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", remap = true } )
map("n", "<C-w><Down>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", remap = true } )
map("n", "<C-w><Right>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", remap = true } )
map("n", "<C-w><Left>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", remap = true } )
map("n", "<leader>!", "<cmd>vsplit<cr>")



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

-- Navigate line
map("n", "<C-a>", "^", opts)
map("n", "<C-e>", "$", opts)

-- Copy whole file
map("n", "<C-c>", "<cmd> %y+ <cr>", opts)

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Move text up and down
map("n", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move Up", silent = true } )
map("n", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move Down", silent = true } )

--
-- Visual_mode = "v",
--

-- Move text up and down
map("v", "<A-j>", ":m .+1<cr>==", { desc = "Move Up", silent = true } )
map("v", "<A-k>", ":m .-2<cr>==", { desc = "Move Down", silent = true } )

--
-- Visual_block_mode = "x",
--

-- Move text up and down
map("x", "<A-j>", ":move '>+1<cr>gv-gv", { desc = "Move Up", silent = true } )
map("x", "<A-k>", ":move '<-2<cr>gv-gv", { desc = "Move Down", silent = true } )

-- Insert_mode = "i",
-- Term_mode = "t",
-- Command_mode = "c",

-- vim: ts=4 sts=4 sw=4 et
