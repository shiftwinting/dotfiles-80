setlocal textwidth=72
setlocal formatoptions+=t
setlocal spell
let b:undo_ftplugin .= '|setlocal spell< textwidth< formatoptions< complete<'
match ErrorMsg /\%1l.\%>50v/
