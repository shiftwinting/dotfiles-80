if !g:use_plugins || exists('g:loaded_diagnostic_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_diagnostic_nvim_config = 1

let g:diagnostic_insert_delay = 1
let g:diagnostic_sign_priority = 1

nnoremap ]g :NextDiagnosticCycle<cr>
nnoremap [g :PrevDiagnosticCycle<cr>
nnoremap gw :OpenDiagnostic<cr>
