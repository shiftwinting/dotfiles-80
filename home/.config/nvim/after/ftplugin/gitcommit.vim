setlocal spell
let b:undo_ftplugin .= '|setlocal spell<'
match ErrorMsg /\%1l.\%>50v/

nnoremap <buffer> <silent> gd :DiffGitCached<CR>
