if !g:use_plugins || !g:is_ide || exists('g:loaded_ale_config')
    finish
endif
let g:loaded_ale_config = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['add_blank_lines_for_python_control_statements', 'autopep8', 'isort', 'yapf',],
\}
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache',
\   },
\ }

let g:ale_completion_enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
