if has('nvim-0.5')
    augroup python-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
endif

let b:undo_ftplugin = '| autocmd! python-fsync'
