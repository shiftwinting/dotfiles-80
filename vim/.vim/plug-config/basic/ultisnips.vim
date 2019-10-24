if !g:use_plugins || !g:is_ide || exists('g:loaded_ultisnips_config')
    finish
endif
let g:loaded_ultisnips_config = 1

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
