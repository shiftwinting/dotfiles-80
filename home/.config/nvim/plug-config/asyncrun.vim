if !g:use_plugins || exists('g:loaded_asyncrun_config')
    finish
endif
let g:loaded_asyncrun_config = 1

let g:asyncrun_open=10
let g:asyncrun_auto = "make"

augroup local-asyncrun
    autocmd!
    autocmd User AsyncRunStop copen | wincmd p
augroup END

function! s:run_tmux(opts)
    " asyncrun has temporarily changed dir for you
    " getcwd() in the runner function is the target directory defined in `-cwd=xxx`  
    let cwd = getcwd()   
    call VimuxRunCommand('cd ' . shellescape(cwd) . '; ' . a:opts.cmd)
endfunction

let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.tmux = function('s:run_tmux')

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

nnoremap m<CR> :execute 'Make' g:targets<CR>
nnoremap m! :execute 'Make!' g:targets<CR>
nnoremap m<Space> :Make<Space>

nnoremap '<CR> :execute 'AsyncRun -mode=term' g:start<CR>
nnoremap '! :execute 'AsyncRun! -mode=term' g:start<CR>
nnoremap '<Space> :AsyncRun -mode=term<Space>
