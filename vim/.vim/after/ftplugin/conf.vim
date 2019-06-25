augroup my_conf
    autocmd!
    autocmd BufWritePost */i3blocks/config !i3-msg restart
augroup END

let b:undo_ftplugin .= '|autocmd! my_conf'
