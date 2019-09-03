setlocal commentstring=//\ %s
let &makeprg="make -C build"
augroup my_cpp
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END
let b:start = 'build/src/adas'
let b:undo_ftplugin .= '|setlocal commentstring< | let &makeprg< | autocmd! my_cpp'
