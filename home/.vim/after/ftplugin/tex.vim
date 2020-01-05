setlocal spell
setlocal complete+=kspell
setlocal formatoptions+=t

let b:surround_{char2nr('e')}
    \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"

let b:ale_fixers = ['latexindent', 'textlint', 'remove_trailing_lines', 'trim_whitespace']

let b:undo_ftplugin = 'setlocal spell< complete< formatoptions<'
