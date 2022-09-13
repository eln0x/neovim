"
" NerdTree
"
" https://github.com/preservim/nerdtree

let NERDTreeShowBookmarks = 1
let NERDTreeWinSize = 40
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore = ['.git[[dir]]', '.swp', '.pyc', '__pycache__', '.egg-info[[dir]]', 'pip-wheel-metadata[[dir]]']
let NERDTreeWinPos = "left"
let g:NERDTreeMouseMode=3

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction

function! NERDTreeToggle()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTreeCWD
    endif
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()
