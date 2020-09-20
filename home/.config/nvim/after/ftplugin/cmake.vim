" augroup my_cmake
"     autocmd! BufWritePost <buffer>
"     autocmd BufWritePost <buffer> CMake
" augroup END
setlocal tabstop=2

" let b:undo_ftplugin .= '|autocmd! my_cmake'
let b:undo_ftplugin .= '| setlocal tabstop<'
