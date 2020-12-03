local cmd = vim.api.nvim_command

local autocmd = function(expr) cmd('autocmd ' .. expr) end

cmd [[ augroup general ]]
cmd [[ autocmd! ]]
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
autocmd [[ BufReadPost * ++once if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" |endif ]]

autocmd [[ BufWritePost *.Xkeymap !xkbcomp % $DISPLAY ]]
autocmd [[ BufWritePost *bspwmrc !bspc wm --restart ]]
autocmd [[ BufWritePost */polybar/config !polybar-msg cmd restart ]]
autocmd [[ BufWritePost *user-dirs.dirs,*user-dirs.locale !xdg-user-dirs-update ]]

autocmd [[ CompleteDone * if pumvisible() == 0 | silent! pclose | endif ]]

autocmd [[ VimLeave * set guicursor=a:block-blinkon0 ]]

autocmd [[ FocusGained,CursorHold,CursorHoldI ?*  if getcmdwintype() == '' | checktime | endif ]]

autocmd [[ TermOpen * startinsert ]]

autocmd [[ TextYankPost * silent! lua vim.highlight.on_yank() ]]

autocmd [[ VimEnter * call v:lua.SourceLocal() ]]

cmd [[ augroup end ]]
