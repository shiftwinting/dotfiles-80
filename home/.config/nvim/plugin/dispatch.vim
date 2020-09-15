if !g:use_plugins || exists('g:loaded_dispatch_config')
    finish
endif
let g:loaded_dispatch_config = 1

let g:dispatch_no_maps = 1

nnoremap m<CR> :execute 'Make' g:targets<CR>
nnoremap m! :execute 'Make!' g:targets<CR>
nnoremap m<Space> :Make<Space>
