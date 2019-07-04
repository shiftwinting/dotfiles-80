augroup editorconfig
    autocmd!
    autocmd BufWritePost *.editorconfig EditorConfigReload
augroup END

let b:undo_ftplugin = 'autocmd! editorconfig'
