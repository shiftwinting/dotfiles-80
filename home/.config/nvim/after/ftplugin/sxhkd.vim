" augroup my_sxhkrc
"     autocmd! BufWritePost <buffer>
"     autocmd BufWritePost <buffer> !pkill -SIGUSR1 sxhkd
" augroup END

" let b:undo_ftplugin .= '|autocmd! my_sxhkrc'
