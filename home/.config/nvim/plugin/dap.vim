if exists('g:loaded_dap_config')
    finish
endif
let g:loaded_dap_config = 1

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F1> :lua require'dap'.repl.open()<CR>
nnoremap <silent> <F2> :lua require'dap'.repl.run_last()<CR>
nnoremap <silent> <F10> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F11> :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <F2> :lua require'dap'.list_breakpoints()<CR>

nnoremap g<CR> :execute 'DebugC' g:dbg_cmd<CR>
nnoremap g<Space> :let @s=g:dbg_cmd<CR>:DebugC<Space><c-r>s<Space>
