setlocal commentstring=!\ %s
augroup my_xdefaults
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> !xrdb %
augroup END

let b:undo_ftplugin .= '|setlocal commentstring< | autocmd! my_xdefaults'
