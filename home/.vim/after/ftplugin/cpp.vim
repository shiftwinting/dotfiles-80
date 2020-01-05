setlocal commentstring=//\ %s
let b:start = g:start
augroup my_cpp
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END

let b:ale_linters = ['ccls', 'clangcheck', 'clangd', 'clangtidy', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'clangtidy', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin .= '|setlocal commentstring< | autocmd! my_cpp | setlocal omnifunc<'