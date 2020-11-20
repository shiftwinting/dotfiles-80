if exists('g:loaded_editorconfig_config')
    finish
endif
let g:loaded_editorconfig_config = 1

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
