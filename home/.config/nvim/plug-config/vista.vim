if !g:use_plugins || exists('g:loaded_vista_config')
    finish
endif
let g:loaded_vista_config = 1

let g:vista_default_executive = 'nvim_lsp'

nnoremap <leader>v :Vista!!<cr>
nnoremap <leader>V :Vista finder fzf:nvim_lsp<cr>
