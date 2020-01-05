if !g:use_plugins || exists('g:loaded_guttentags_config')
    finish
endif
let g:loaded_guttentags_config = 1

let g:guttentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendmail', 'git']
