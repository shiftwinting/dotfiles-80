if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
syntax match Comment +\/\/.\+$+
let b:undo_ftplugin = 'setlocal omnifunc<'
