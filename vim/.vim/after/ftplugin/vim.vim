augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source $MYVIMRC | Runtime
augroup END

let b:undo_ftplugin .= '|autocmd! my_vim'
