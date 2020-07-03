setlocal formatoptions-=t
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    augroup sh-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
endif
let b:undo_ftplugin .= '|setlocal formatoptions< omnifunc<'
