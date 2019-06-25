setlocal formatexpr=CocAction('formatSelected')
let b:undo_ftplugin .= '|setlocal formatexpr<'
syntax match Comment +\/\/.\+$+
