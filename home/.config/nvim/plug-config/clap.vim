if !g:use_plugins || exists('g:loaded_clap_config')
    finish
endif
let g:loaded_clap_config = 1

let g:clap_disable_run_rooter=v:true
nnoremap <silent><localleader>f :Clap files ++finder=fd --type f --follow --hidden --exclude '.git'<CR>
nnoremap <silent><localleader>b :Clap buffers<CR>
nnoremap <silent><localleader>g :Clap grep<CR>
