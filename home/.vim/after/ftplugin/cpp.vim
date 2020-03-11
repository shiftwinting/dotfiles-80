setlocal commentstring=//\ %s
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif

let b:ale_linters = ['clangcheck', 'clangtidy', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'clangtidy', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin .= 'setlocal omnifunc< |setlocal commentstring<'
