let b:start = g:start

augroup my_cmake
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> CMake
augroup END

let b:undo_ftplugin .= '|autocmd! my_cmake'

