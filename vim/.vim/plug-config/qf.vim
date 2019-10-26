if !g:use_plugins || exists('g:loaded_qf_config')
    finish
endif
let g:loaded_qf_config = 1

nmap <silent> <localleader>q <Plug>(qf_qf_toggle_stay)
