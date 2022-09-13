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

-- Navigate tabs
keymap("n", "<C-t>", ":tabnew<CR>", opts)
keymap("n", "<C-PageDown>", ":tabprev<CR>", opts)
keymap("n", "<C-PageUp>", ":tabnext<CR>", opts)

-- Navigate buffers
keymap("n", "<leader><Right>", ":bnext<CR>", opts)
keymap("n", "<leader><Left>", ":bprev<CR>", opts)

-- Toggles
keymap("n", "<F1>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<F2>", ":TagbarToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope repo list<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)

-- Insert_mode = "i",
-- Visual_mode = "v",
-- Visual_block_mode = "x",
-- Term_mode = "t",
-- Command_mode = "c",
