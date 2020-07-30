setlocal commentstring=//\ %s
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    " augroup cpp-fsync
    "     autocmd! BufWritePre <buffer>
    "     autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    " augroup end
endif

let b:ale_linters = []
let b:ale_fixers = ['clang-format', 'clangtidy', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin .= '| setlocal omnifunc< commentstring<'
