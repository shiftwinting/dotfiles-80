setlocal commentstring=//\ %s
augroup my_c
    autocmd!
    autocmd BufWritePost config.h !make clean install
augroup END

let b:undo_ftplugin .= '|setlocal commentstring< |autocmd! my_c'
