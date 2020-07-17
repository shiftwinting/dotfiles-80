if !g:use_plugins || exists('g:loaded_completion_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_completion_nvim_config = 1

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_auto_hover = 1
let g:completion_matching_ignore_case = 1
let g:completion_auto_change_source = 1

imap  <c-j> <Plug>(completion_next_source)
imap  <c-k> <Plug>(completion_prev_source)

let g:completion_chain_complete_list = {
    \   'default': {
    \       'default': [
    \           {'complete_items': ['lsp']},
    \           {'complete_items': ['snippet']},
    \           {'complete_items': ['ts']},
    \           {'complete_items': ['buffers']},
    \       ],
    \       'string' : [
    \           {'complete_items': ['path'], 'triggered_only': ['/']}
    \       ]
    \   },
    \}

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()
