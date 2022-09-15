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

-- Insert_mode = "i",
-- Visual_mode = "v",
-- Visual_block_mode = "x",
-- Term_mode = "t",
-- Command_mode = "c",
