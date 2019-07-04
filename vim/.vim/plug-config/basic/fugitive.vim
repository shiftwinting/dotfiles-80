if !g:use_plugins || exists('g:loaded_fugitive_config')
    finish
endif
let g:loaded_fugitive_config = 1

let g:fugitive_gitlab_domains = ['http://gitlab.xesol.innovation.local']

