if !g:use_plugins || exists('g:loaded_muc_config')
    finish
endif
let g:loaded_muc_config = 1

let g:mucomplete#enable_auto_at_startup = 1


inoremap <silent> <expr> <plug>UltiExpand
        \ mucomplete#ultisnips#expand_snippet("\<cr>")
imap <plug>MyCR <plug>UltiExpand<plug>DiscretionaryEnd
imap <cr> <plug>MyCR
