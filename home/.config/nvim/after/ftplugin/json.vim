if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    augroup json-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
endif
syntax match Comment +\/\/.\+$+
let b:undo_ftplugin = 'setlocal omnifunc<'
