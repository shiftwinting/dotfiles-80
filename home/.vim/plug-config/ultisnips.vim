if !g:use_plugins || exists('g:loaded_ultisnips_config') || !has('python3')
    finish
endif
let g:loaded_ultisnips_config = 1

if !has('nvim-0.5')
    let g:UltiSnipsExpandTrigger="<c-s>"
endif
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
