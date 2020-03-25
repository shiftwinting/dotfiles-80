setlocal formatoptions-=t
augroup my_i3
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> !i3-msg reload
augroup END
let b:undo_ftplugin = 'setlocal formatoptions< | autocmd! my_i3'
