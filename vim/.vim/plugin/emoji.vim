if !executable('emoji') || exists('g:loaded_emoji')
    finish
endif
let g:loaded_emoji = 1

function! Write_emoji()
    return system('emoji')
endfunction

nnoremap <silent><leader>e "=Write_emoji()<CR>P
