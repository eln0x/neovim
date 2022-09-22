--
-- NeoVim keymaps
--

local keymap = vim.keymap.set
local opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

--
-- Normal_mode = "n",
--

-- Copy whole file
keymap("n", "<C-c>", "<cmd> %y+ <CR>", opts)

-- Move text up and down
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

-- Navigate line
keymap("n", "<C-a>", "^", opts)
keymap("n", "<C-e>", "$", opts)

-- Navigate tabs
keymap("n", "<C-t>", "<cmd>tabnew<cr>", opts)
keymap("n", "<C-PageDown>", "<cmd>tabprev<cr>", opts)
keymap("n", "<C-PageUp>", "<cmd>tabnext<cr>", opts)

-- Navigate windows
keymap("n", "<C-w><Up>", "<cmd>wincmd k<cr>")
keymap("n", "<C-w><Down>", "<cmd>wincmd j<cr>")
keymap("n", "<C-w><Right>", "<cmd>wincmd l<cr>")
keymap("n", "<C-w><Left>", "<cmd>wincmd h<cr>")

-- Navigate buffers
keymap("n", "<leader><Right>", "<cmd>bnext<cr>", opts)
keymap("n", "<leader><Left>", "<cmd>bprev<cr>", opts)

-- Toggles
keymap("n", "<F1>", "<cmd>NvimTreeToggl<cr>", opts)
keymap("n", "<F2>", "<cmd>TagbarToggle<cr>", opts)
keymap("n", "<F3>", "<cmd>Alpha<cr>", opts)
keymap("n", "<F4>", "<cmd>AerialToggle<cr>", opts)
keymap("n", "<F5>", "<cmd>Mason<cr>", opts)
keymap("n", "<F6>", "<cmd>NullLsInfo<cr>", opts)

-- Cmotion
vim.g.comfortable_motion_no_default_key_mappings = 1
keymap('n', '<C-Down>', '<cmd>call comfortable_motion#flick(100)<cr>', opts)
keymap('n', '<C-Up>', '<cmd>call comfortable_motion#flick(-100)<cr>', opts)
keymap('n', '<C-f>', '<cmd>call comfortable_motion#flick(200)<cr>', opts)
keymap('n', '<C-b>', '<cmd>call comfortable_motion#flick(-200)<cr>', opts)

-- Insert_mode = "i",

--
-- Visual_mode = "v",
--

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

--
-- Visual_block_mode = "x",
--

-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Term_mode = "t",
-- Command_mode = "c",
