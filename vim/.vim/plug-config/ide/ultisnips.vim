if !g:use_plugins || !g:is_ide || exists('g:loaded_ultisnips_config')
    finish
endif
let g:loaded_ultisnips_config = 1

let g:UltiSnipsExpandTrigger="<c-w>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
