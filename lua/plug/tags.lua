--
-- Tagbar configuration
--
-- https://github.com/preservim/tagbar

vim.cmd [[
    let g:tagbar_map_showproto = '\'
    let g:tagbar_sort = 0
    let g:tagbar_compact = 1
    let g:tagbar_autoshowtag = 1
    let g:tagbar_previewwin_pos = "aboveleft"
    let g:tagbar_autopreview = 0
    let g:tagbar_singleclick = 1
    let g:tagbar_autofocus = 1
]]

--
-- Gutentags
--
-- https://github.com/ludovicchabant/vim-gutentags

vim.cmd [[
    let g:gutentags_project_root = ['.project']
    let g:gutentags_cache_dir = '~/.cache/nvim/tags'
    let g:gutentags_exclude_project_root = []
    let g:gutentags_exclude_filetypes = []
    let g:gutentags_add_default_project_roots = 0
    let g:gutentags_resolve_symlinks = 1
    let g:gutentags_modules = ['ctags', 'cscope']
    let g:gutentags_ctags_extra_args = ['--fields=+niaSszt --extra=+q --python-kinds=-vi --tag-relative=yes']
    let g:gutentags_file_list_command = 'find . -type f -regextype posix-egrep -regex ".*\.(py|go|pl|sh)$" -not -path "*/\.*" -follow'
    let g:gutentags_enabled_user_func = 'GutentagsEnableFunc'
]]

vim.cmd [[
    function! GutentagsEnableFunc(path)
        let file_ext = fnamemodify(a:path, ':e')
        let allowed_file_ext = ['py', 'go', 'pl', 'sh']
        if (index(allowed_file_ext, file_ext) >= 0) | return 1 | else | return 0 | endif
    endfunction
]]
