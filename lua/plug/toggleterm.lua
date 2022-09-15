--
-- Toggle terminal configuration
--
-- https://github.com/akinsho/toggleterm.nvim

local term_ok, toggleterm = pcall(require, "toggleterm")
if not term_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
    },
})

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<leader><UP>', [[<cmd>wincmd k<cr>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local Lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function LazyGitToggle()
	Lazygit:toggle()
end