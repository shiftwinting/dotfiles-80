setlocal commentstring=//\ %s
if has('nvim-0.5')
    " augroup cpp-fsync
    "     autocmd! BufWritePre <buffer>
    "     autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    " augroup end
    nnoremap gH :ClangdSwitchSourceHeader<cr>
endif

let b:undo_ftplugin .= '| setlocal commentstring<'
