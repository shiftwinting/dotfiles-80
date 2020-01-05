setlocal commentstring=!\ %s
augroup my_xdefaults
    autocmd!
    autocmd BufWritePost *.Xresources,*.Xdefaults !xrdb %
augroup END

let b:undo_ftplugin .= '|setlocal commentstring< | autocmd! my_xdefaults'
