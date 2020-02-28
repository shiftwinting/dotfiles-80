if !g:use_plugins || exists('g:loaded_asyncomplete_config')
    finish
endif
let g:loaded_asyncomplete_config = 1

imap <M-space> <Plug>(asyncomplete_force_refresh)
" let g:asyncomplete_popup_delay = 300
let g:asyncomplete_auto_completeopt = 0
if executable('python3') && (has('nvim') || has('python3'))
    augroup async_ulti
        autocmd!
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
            \ 'name': 'ultisnips',
            \ 'whitelist': ['*'],
            \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
            \ }))
    augroup END
endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
