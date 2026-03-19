-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local vim = vim

local set = vim.keymap.set
local del = vim.keymap.del

-- Scroll inside terminal
local function term_scroll(direction, count)
    count = count or 5
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "n", false)
    vim.cmd("normal! " .. count .. direction)
end

-- Toggles
set("n", "<F2>", "<cmd>Alpha<cr>", { silent = true })
set("n", "<F3>", "<cmd>Mason<cr>", { silent = true })
set("n", "<F4>", "<cmd>LspInfo<cr>", { silent = true })
set("n", "<F5>", "<cmd>ConformInfo<cr>", { silent = true })
set("n", "<F6>", "<cmd>HuezFavorites<cr>", { silent = true })

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

-- Navigate terminal
set("t", "<C-w><Left>", [[<C-\><C-n><C-w>h]], { desc = "Go to Left Terminal", remap = true })
set("t", "<C-w><Right>", [[<C-\><C-n><C-w>l]], { desc = "Go to Right Terminal", remap = true })
set("t", "<C-w><Up>", [[<C-\><C-n><C-w>k]], { desc = "Go to Upper Terminal", remap = true })
set("t", "<C-w><Down>", [[<C-\><C-n><C-w>j]], { desc = "Go to Lower Terminal", remap = true })

-- Exit terminal
set("t", "<C-Left>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })
set("t", "<C-Right>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- Scroll terminal
set("t", "<C-Up>", function() term_scroll("k", 5) end, { remap = true, silent = true, desc = "Scroll up 5 lines" })
set("t", "<C-Down>", function() term_scroll("j", 5) end, { remap = true, silent = true, desc = "Scroll down 5 lines" })

-- Copy whole file
set("n", "<C-c>", "<cmd> %y+ <cr>", { silent = true })
set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Comfortable motion
vim.g.comfortable_motion_no_default_key_mappings = 1
del("n", "<leader>uS")
del("n", "<C-Down>")
set("n", "<C-Down>", "<cmd>call comfortable_motion#flick(100)<cr>", { desc = "Scroll Down", silent = true })
del("n", "<C-Up>")
set("n", "<C-Up>", "<cmd>call comfortable_motion#flick(-100)<cr>", { desc = "Scroll Up", silent = true })

-- vim: ts=4 sts=4 sw=4 et
