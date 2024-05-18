-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local vim = vim

vim.cmd [[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
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
