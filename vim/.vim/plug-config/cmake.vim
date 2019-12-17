if !g:use_plugins || exists('g:loaded_cmake_config')
    finish
endif
let g:loaded_cmake_config = 1

let g:cmake_export_compile_commands=1
let g:cmake_ycm_symlinks=1
