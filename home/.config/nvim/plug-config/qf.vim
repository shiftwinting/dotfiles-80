if !g:use_plugins || exists('g:loaded_qf_config')
    finish
endif
let g:loaded_qf_config = 1

let g:qf_shorten_path = 0
nmap <silent> <localleader>q <Plug>(qf_qf_toggle_stay)
nmap <silent> <localleader>l <Plug>(qf_loc_toggle_stay)
