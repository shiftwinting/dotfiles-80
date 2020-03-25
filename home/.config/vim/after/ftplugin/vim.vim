if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
augroup END

let b:undo_ftplugin .= '| setlocal omnifunc< |autocmd! my_vim'
