augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source % | source $MYVIMRC
augroup END

let b:undo_ftplugin .= '|autocmd! my_vim'
