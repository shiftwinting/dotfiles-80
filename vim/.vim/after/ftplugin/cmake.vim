command! CMake !mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug ..
command! CClean !rm -rf build && mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=/usr/bin/gcc-9 -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 ..
augroup my_cmake
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> CMake
augroup END
let b:undo_ftplugin .= '|autocmd! my_cmake'
