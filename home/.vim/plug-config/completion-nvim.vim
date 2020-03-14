if !g:use_plugins || exists('g:loaded_completion_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_completion_nvim_config = 1

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_auto_hover = 0
