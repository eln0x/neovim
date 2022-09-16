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

-- Save
keymap("n", "<C-S>", "<cmd>w<cr>")

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Split
keymap("n", "<leader>!", "<cmd>vsplit<cr>")
keymap("n", "<leader>/", "<cmd>split<cr>")

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

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelete!<CR>", opts)

-- Toggles
keymap("n", "<F1>", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "<F2>", "<cmd>TagbarToggle<cr>", opts)
keymap("n", "<F3>", "<cmd>Alpha<cr>", opts)
keymap("n", "<leader>tt", "<cmd>ToggleTerm dir=%:p:h<cr>", opts)
keymap("n", "<leader>tg", "<cmd>lua LazyGitToggle()<CR>", opts)
keymap("n", "<leader>ta", "<cmd>AerialToggle<cr>", opts)
keymap("n", "<leader>ti", "<cmd>IndentLinesToggle<cr>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>w", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>m", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>c", "<cmd>Telescope colorscheme<cr>", opts)

-- Lsp
keymap("n", "<leader>i", "<cmd>LspInfo<cr>", opts)

-- Insert_mode = "i",
-- Visual_mode = "v",
-- Visual_block_mode = "x",
-- Term_mode = "t",
-- Command_mode = "c",
