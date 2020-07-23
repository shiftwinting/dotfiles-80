if !g:use_plugins || exists('g:loaded_fugitive_config')
    finish
endif
let g:loaded_fugitive_config = 1

set statusline+=%{FugitiveHead()}
