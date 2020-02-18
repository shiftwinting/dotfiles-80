if !has("autocmd") || exists('g:loaded_autocmds')
    finish
endif
let g:loaded_autocmds = 1

augroup remember-position
    autocmd!
    " When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
    autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

augroup reload
    autocmd!
    autocmd BufWritePost *.Xkeymap !xkbcomp % $DISPLAY
    autocmd BufWritePost *bspwmrc !bspc wm --restart
    autocmd BufWritePost */polybar/config !polybar-msg cmd restart
    autocmd BufWritePost *user-dirs.dirs,*user-dirs.locale !xdg-user-dirs-update
augroup END

augroup compl
    autocmd!
    autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup end

augroup restore-cursor
    autocmd!
    autocmd VimLeave * set guicursor=a:block-blinkon0
augroup END

if has("terminal")
    if has("nvim")
        augroup terminal_buff
            autocmd!
            autocmd TermOpen * startinsert
        augroup END
    else
        augroup terminal_buff
            autocmd!
            autocmd TerminalOpen * startinsert
        augroup END
    endif
endif
