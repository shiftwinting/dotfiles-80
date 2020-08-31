if !g:use_plugins || exists('g:loaded_cmake_config')
    finish
endif
let g:loaded_cmake_config = 1

let g:cmake_export_compile_commands=1
let g:cmake_ycm_symlinks=1
" let g:cmake_build_shared_libs=v:true
let g:cmake_project_generator="Ninja"
let g:cmake_c_compiler='/usr/bin/clang'
let g:cmake_cxx_compiler='/usr/bin/clang++'
let g:cmake_install_prefix='install'
let g:cmake_usr_args='-DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache'
