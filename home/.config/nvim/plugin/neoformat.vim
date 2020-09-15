if !g:use_plugins || exists('g:loaded_neoformat_config')
    finish
endif
let g:loaded_neoformat_config = 1

let g:neoformat_try_formatprg = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
let g:shfmt_opt="-ci"

nnoremap <leader>n :Neoformat<cr>
xnoremap <leader>n :Neoformat<cr>
