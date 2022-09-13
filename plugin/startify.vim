"
" Startify
"
" https://github.com/mhinz/vim-startify

" load Startify and NerdTree at startup
autocmd VimEnter *
    \   if !argc()
    \ |   Startify
    \ |   NERDTree
    \ |   wincmd w
    \ | endif

" startify config
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = '~/.cache/nvim/session'
let g:startify_session_persistence = 1
let g:startify_session_before_save = [
\   'echo "Cleaning up before saving.."',
\   'silent! NERDTreeTabsClose',
\   'silent! NERDTreeClose',
\   'silent! TagbarClose',
\ ]
let g:startify_bookmarks = []
let g:startify_lists = [
\   { 'type': 'sessions',  'header': ['   Sessions']    },
\   { 'type': 'files',     'header': ['   Files']       },
\   { 'type': 'bookmarks', 'header': ['   Bookmarks']   },
\]
