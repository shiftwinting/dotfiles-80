setlocal commentstring=//\ %s
augroup my_cpp
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END

if executable('clangd') || executable('cquery')
    setlocal omnifunc=lsp#complete
endif
let b:ale_linters = ['ccls', 'clangcheck', 'clangd', 'clangtidy', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'clangtidy', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin .= '|setlocal commentstring< | autocmd! my_cpp | setlocal omnifunc<'
