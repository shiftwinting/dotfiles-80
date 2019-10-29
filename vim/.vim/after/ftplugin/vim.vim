augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source $MYVIMRC
augroup END

let b:undo_ftplugin .= '|autocmd! my_vim'
