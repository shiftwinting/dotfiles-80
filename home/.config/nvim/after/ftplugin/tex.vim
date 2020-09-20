setlocal spell
setlocal complete+=kspell
setlocal formatoptions+=t
if has('nvim-0.5')
    augroup tex-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
endif

let b:surround_{char2nr('e')}
    \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"

let b:undo_ftplugin = 'setlocal spell< complete< formatoptions<'
