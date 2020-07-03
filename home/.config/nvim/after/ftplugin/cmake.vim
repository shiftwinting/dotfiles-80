if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    augroup cmake-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
endif
" augroup my_cmake
"     autocmd! BufWritePost <buffer>
"     autocmd BufWritePost <buffer> CMake
" augroup END

" let b:undo_ftplugin .= '|autocmd! my_cmake'
let b:undo_ftplugin .= '| setlocal omnifunc<'
