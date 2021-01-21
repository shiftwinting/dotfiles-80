augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
augroup END
