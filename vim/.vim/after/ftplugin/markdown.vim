setlocal spell
setlocal complete+=kspell
set formatoptions-=t

let b:undo_ftplugin .= '|setlocal spell< complete< formatoptions<'

