if !g:use_plugins || exists('g:loaded_airline_config')
    finish
endif
let g:loaded_airline_config = 1

let g:airline_theme= 'base16_gruvbox_dark_hard'
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
