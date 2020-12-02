if !has("autocmd") || exists('g:loaded_autocmds')
    finish
endif
let g:loaded_autocmds = 1

augroup general
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost * ++once
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

    autocmd BufWritePost *.Xkeymap !xkbcomp % $DISPLAY
    autocmd BufWritePost *bspwmrc !bspc wm --restart
    autocmd BufWritePost */polybar/config !polybar-msg cmd restart
    autocmd BufWritePost *user-dirs.dirs,*user-dirs.locale !xdg-user-dirs-update

    autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif

    autocmd VimLeave * set guicursor=a:block-blinkon0

    autocmd FocusGained,CursorHold,CursorHoldI ?*  if getcmdwintype() == '' | checktime | endif

    autocmd TermOpen * startinsert

    autocmd TextYankPost * silent! lua vim.highlight.on_yank()


    let s:local_vimrc=".doit.vim"
    autocmd VimEnter * if filereadable(".doit.vim") | echo "sourcing local config" | source .doit.vim | endif
augroup end
