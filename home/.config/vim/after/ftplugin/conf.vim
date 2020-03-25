setlocal commentstring=#\ %s
augroup my_conf
    autocmd!
    autocmd BufWritePost */i3blocks/config !i3-msg restart
augroup END

let b:undo_ftplugin .= '| setlocal commentstring< |autocmd! my_conf'
