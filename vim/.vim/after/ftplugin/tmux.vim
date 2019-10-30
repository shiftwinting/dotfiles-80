augroup my_tmux
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> make
augroup END

let b:undo_ftplugin = '|autocmd! my_tmux'
