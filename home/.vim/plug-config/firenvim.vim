if !g:use_plugins || exists('g:loaded_firenvim_config') || !exists('g:started_by_firenvim')
    finish
endif
let g:loaded_firenvim_config = 1

let g:firenvim_config = { 
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'firenvim',
            \ 'selector': 'textarea, div[role="textbox"]',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
nnoremap <C-z> :call firenvim#hide_frame()<CR>
