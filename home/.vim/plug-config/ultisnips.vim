if !g:use_plugins || exists('g:loaded_ultisnips_config') ||!(executable('python3') && (has('nvim') || has('python3')))
    finish
endif
let g:loaded_ultisnips_config = 1

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
