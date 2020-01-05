setlocal laststatus=0
setlocal noshowmode
setlocal noruler

augroup my_fzf
    autocmd! BufLeave <buffer>
    autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let b:undo_ftplugin = 'setlocal laststatus< showmode< ruler<'
