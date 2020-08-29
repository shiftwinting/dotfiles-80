if !g:use_plugins || exists('g:loaded_asyncrun_config')
    finish
endif
let g:loaded_asyncrun_config = 1

function! s:run_tmux(opts)
    " asyncrun has temporarily changed dir for you
    " getcwd() in the runner function is the target directory defined in `-cwd=xxx`  
    let cwd = getcwd()   
    call VimuxRunCommand('cd ' . shellescape(cwd) . '; ' . a:opts.cmd)
endfunction

let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.tmux = function('s:run_tmux')

nnoremap '<CR> :execute 'AsyncRun -mode=term' g:start<CR>
nnoremap '! :execute 'AsyncRun! -mode=term' g:start<CR>
nnoremap '<Space> :AsyncRun -mode=term<Space>
