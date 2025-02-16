--
-- NeoVim autocommands
--
-- Add any additional autocmds here

local vim = vim

local function augroup(name)
    return vim.api.nvim_create_augroup("_" .. name, { clear = true })
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.cmd [[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd BufWinEnter * :set formatoptions-=cro
        autocmd BufWritePre * :%s/\s\+$//e
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup end
]]

vim.cmd [[
    augroup _filetype_settings
        autocmd!
        autocmd FileType qf set nobuflisted
        autocmd FileType c,cpp,cxx,h set cindent
        autocmd FileType make setlocal noexpandtab
        autocmd BufNewFile,BufRead *.lib set filetype=sh
        autocmd BufNewFile,BufRead *.source set filetype=sh
        autocmd BufNewFile,BufRead *.pp set filetype=puppet
        autocmd BufNewFile,BufRead *.inc set filetype=perl
        autocmd BufRead,BufNewFile *.tex set filetype=tex
        autocmd BufRead,BufNewFile *.cls set filetype=tex
    augroup end
]]

vim.cmd [[
    augroup __remember_folds
        autocmd!
        au BufWinLeave ?* mkview 1
        au BufWinEnter ?* silent! loadview 1
    augroup END
]]

-- vim: ts=4 sts=4 sw=4 et
