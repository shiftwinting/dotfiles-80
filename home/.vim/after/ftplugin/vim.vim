augroup my_vim
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
        \|  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | q | source $MYVIMRC
        \| endif
augroup END

let b:undo_ftplugin .= '|autocmd! my_vim'
