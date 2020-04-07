if !g:use_plugins || exists('g:loaded_completion_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_completion_nvim_config = 1

let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_enable_auto_hover = 0
let g:completion_auto_change_source = 1
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_max_items = 5

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()
