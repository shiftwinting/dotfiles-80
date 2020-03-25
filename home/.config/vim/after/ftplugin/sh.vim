setlocal formatoptions-=t
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
let b:undo_ftplugin .= '|setlocal formatoptions< omnifunc<'
