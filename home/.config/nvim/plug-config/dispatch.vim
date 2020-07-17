if !g:use_plugins || exists('g:loaded_dispatch_config')
    finish
endif
let g:loaded_dispatch_config = 1

let g:dispatch_no_maps = 1

nnoremap m<CR> :execute 'Make' g:targets<CR>
nnoremap '! :execute 'Make!' g:targets<CR>
nnoremap m<Space> :let @s=g:targets<CR>:Make<Space><c-r>s<Space>

nnoremap '<CR> :execute 'Start' g:start<CR>
nnoremap '<Space> :let @s=g:start<CR>:Start<Space><c-r>s<Space>
nnoremap '! :execute 'Start!' g:start<CR>
