setlocal commentstring=//\ %s
let &makeprg="make -j8 -C build"
augroup my_cpp
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END
let b:undo_ftplugin .= '|setlocal commentstring< | let &makeprg< | autocmd! my_cpp'
