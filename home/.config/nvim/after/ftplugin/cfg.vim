setlocal commentstring=#\ %s
augroup my_cfg
    autocmd!
    autocmd BufWritePost *dunstrc !systemctl --user restart dunst
augroup END

let b:undo_ftplugin = '|setlocal commentstring< | autocmd! my_cfg'
