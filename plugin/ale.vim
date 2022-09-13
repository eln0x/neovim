"
" Ale
"
" https://github.com/dense-analysis/ale

let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'Err'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'
let g:ale_linters = {
\   'python': ['flake8'],
\   'go': ['gometalinter', 'gofmt'],
\ }
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }
