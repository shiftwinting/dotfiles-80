if !g:use_plugins || !g:is_ide || exists('g:loaded_ale_config')
    finish
endif
let g:loaded_ale_config = 1

let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\   	'python': ['add_blank_lines_for_python_control_statements', 'autopep8', 'isort', 'yapf',],
\	'tex': ['latexindent', 'textlint',],
\}
let g:ale_linters = {
\   'cpp': ['cppcheck', 'clangcheck', 'clangtidy', 'cquery',],
\}
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache',
\   },
\ }

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)
let g:airline#extensions#ale#enabled = 1
let g:ale_close_preview_on_insert = 1
