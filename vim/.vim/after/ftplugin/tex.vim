setlocal spell
setlocal complete+=kspell
setlocal formatoptions+=t

let b:ale_fixers = ['latexindent', 'textlint', 'remove_trailing_lines', 'trim_whitespace']

let b:undo_ftplugin = 'setlocal spell< complete< formatoptions<'
