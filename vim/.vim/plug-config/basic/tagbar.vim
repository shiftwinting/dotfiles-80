if !g:use_plugins || exists('g:loaded_tagbar_config')
    finish
endif
let g:loaded_tagbar_config = 1

nmap <F8> :TagbarToggle<CR>
