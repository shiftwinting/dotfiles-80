setlocal spell
nnoremap <localleader>p :Glow<cr>

let b:switch_custom_definitions =
    \ [
    \   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
    \     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
    \     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
    \   },
    \   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
    \     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
    \     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
    \   },
    \ ]

let b:undo_ftplugin .= '|setlocal spell<'
