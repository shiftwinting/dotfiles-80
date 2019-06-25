if !g:use_plugins || !has('nvim') || exists('g:loaded_suda_config')
    finish
endif
let g:loaded_suda_config = 1

command! SW write suda://%
