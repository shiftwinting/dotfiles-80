augroup my_c
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END

let b:undo_ftplugin .= '|autocmd! my_c'
