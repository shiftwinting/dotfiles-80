if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
syntax match Comment +\/\/.\+$+
setlocal tabstop=2
let b:undo_ftplugin = 'setlocal omnifunc<'
