augroup my_xmodmap
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> !xmodmap ~/.Xmodmap
augroup END

let b:undo_ftplugin .= '|autocmd! my_xmodmap'
