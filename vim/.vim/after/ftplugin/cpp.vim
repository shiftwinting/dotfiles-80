setlocal commentstring=//\ %s
let &makeprg="make -j8 -C build"
command! CMake !mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ..
command! CClean !rm -rf build && mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ..
augroup my_cpp
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END
let b:undo_ftplugin .= '|setlocal commentstring< | let &makeprg< | autocmd! my_cpp'
