--
-- NeoVim autocommands
--

vim.cmd [[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
        autocmd BufWinEnter * :set formatoptions-=cro
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
