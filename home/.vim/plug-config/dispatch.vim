if !g:use_plugins || exists('g:loaded_dispatch_config')
    finish
endif
let g:loaded_dispatch_config = 1

let g:dispatch_no_maps = 1

nnoremap m<CR> :Dispatch<CR>
nnoremap m<Space> :Dispatch<Space>
nnoremap m! :Dispatch!<CR>

nnoremap '<CR> :execute 'Start' g:start<CR>
nnoremap '<Space> :let @s=g:start<CR>:Start<Space><c-r>s<Space>
nnoremap '! :execute 'Start!' g:start<CR>
