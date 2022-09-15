--
-- NeoVim autocommands
--

-- file indent by type
vim.cmd "autocmd FileType c,cpp,cxx,h set cindent"
vim.cmd "autocmd FileType make setlocal noexpandtab"

-- file type
vim.cmd "autocmd BufNewFile,BufRead *.lib set filetype=sh"
vim.cmd "autocmd BufNewFile,BufRead *.source set filetype=sh"
vim.cmd "autocmd BufNewFile,BufRead *.pp set filetype=puppet"
vim.cmd "autocmd BufNewFile,BufRead *.inc set filetype=perl"
vim.cmd "autocmd BufRead,BufNewFile *.tex set filetype=tex"
vim.cmd "autocmd BufRead,BufNewFile *.cls set filetype=tex"
