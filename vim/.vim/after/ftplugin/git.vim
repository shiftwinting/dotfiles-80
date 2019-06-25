setlocal textwidth=79
setlocal formatoptions+=t
setlocal spell
setlocal complete+=kspell
let b:undo_ftplugin .= '|setlocal spell< textwidth< formatoptions< complete<'
match ErrorMsg /\%1l.\%>81v/
exec 'normal gg' | startinsert!

