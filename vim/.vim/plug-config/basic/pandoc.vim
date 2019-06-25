if !g:use_plugins || exists('g:loaded_pandoc_config')
    finish
endif
let g:loaded_pandoc_config = 1

let g:pandoc#syntax#conceal#use = 0
