setlocal spell
setlocal complete+=kspell
set commentstring=#\ %s
let b:undo_ftplugin .= '|setlocal spell< complete< commentstring<'
