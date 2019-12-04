if !g:use_plugins || exists('g:loaded_asyncomplete_config')
    finish
endif
let g:loaded_asyncomplete_config = 1

imap <c-space> <Plug>(asyncomplete_force_refresh)

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

if executable('ctags') || executable('ctags-exuberant')
    augroup async_ctags
        autocmd!
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
        \ 'name': 'tags',
        \ 'whitelist': ['c'],
        \ 'completor': function('asyncomplete#sources#tags#completor'),
        \ 'config': {
        \    'max_file_size': 50000000,
        \  },
        \ }))
    augroup END
endif

augroup async_neco
    autocmd!
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'whitelist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))
augroup END

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
