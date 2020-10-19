if !g:use_plugins || exists('g:loaded_completion_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_completion_nvim_config = 1

let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_matching_ignore_case = 1
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_enable_auto_paren=1
let g:completion_trigger_on_delete = 1

imap  <c-j> <Plug>(completion_next_source)
imap  <c-k> <Plug>(completion_prev_source)

let g:completion_chain_complete_list = {
    \   'default': {
    \       'default': [
    \           {'complete_items': ['lsp', 'snippet']},
    \           {'complete_items': ['ts']},
    \       ],
    \       'string' : [
    \           {'complete_items': ['path'], 'triggered_only': ['/']},
    \           {'complete_items': ['buffers']},
    \       ],
    \       'comment' : [
    \           {'complete_items': ['buffers', 'path']}
    \       ],
    \   },
    \   'tex': {
    \       'default': [
    \           {'complete_items': ['vimtex', 'lsp', 'snippet']},
    \           {'complete_items': ['ts']},
    \           {'complete_items': ['buffers']},
    \       ],
    \       'comment' : [
    \           {'complete_items': ['buffers']}
    \       ],
    \   }
    \}

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
        \ "\<Plug>(completion_confirm_completion)"  :
        \ "\<c-e>\<CR>" : "\<CR>"
