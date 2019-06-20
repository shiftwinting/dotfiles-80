if executable('emoji')
    function! Write_emoji()
        return system('emoji')
    endfunction

    nnoremap <leader>e "=Write_emoji()<CR>P
endif
