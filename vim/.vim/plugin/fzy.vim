if !executable('fzy') || exists('g:loaded_fzy')
    finish
endif
let g:loaded_fzy = 1

if has('nvim')
    function! FzyCommand(choice_command, vim_command) abort
        let l:callback = {
                    \ 'window_id': win_getid(),
                    \ 'filename': tempname(),
                    \  'vim_command':  a:vim_command
                    \ }

        function! l:callback.on_exit(job_id, data, event) abort
            bdelete!
            call win_gotoid(self.window_id)
            if filereadable(self.filename)
                try
                    let l:selected_filename = readfile(self.filename)[0]
                    exec self.vim_command . l:selected_filename
                catch /E684/
                endtry
            endif
            call delete(self.filename)
        endfunction

        botright 10 new
        let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
        silent call termopen(l:term_command, l:callback)
        setlocal nonumber norelativenumber
        startinsert
    endfunction
else
    function! FzyCommand(choice_command, vim_command)
        try
            let output = system(a:choice_command . " | fzy ")
        catch /Vim:Interrupt/
            " Swallow errors from ^C, allow redraw! below
        endtry
        redraw!
        if v:shell_error == 0 && !empty(output)
            exec a:vim_command . ' ' . output
        endif
    endfunction
endif

nnoremap <silent><leader>t :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":tabedit")<cr>
nnoremap <silent><leader>h :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":split")<cr>
nnoremap <silent><leader>v :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":vsplit")<cr>
