if has('nvim-0.5')
    augroup luasource
        autocmd! BufWritePost <buffer>
        autocmd BufWritePost <buffer> luafile %
    augroup end
endif
