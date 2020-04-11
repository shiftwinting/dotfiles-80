augroup my_xml
    autocmd!
    autocmd BufWritePost *fonts.conf !fc-cache
augroup END

let b:undo_ftplugin .= '|autocmd! my_xml'

