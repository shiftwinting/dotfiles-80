if !g:use_plugins || exists('g:loaded_diagnostic_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_diagnostic_nvim_config = 1

let g:diagnostic_insert_delay = 1

nnoremap ]g :NextDiagnostic<cr>
nnoremap [g :PrevDiagnostic<cr>
nnoremap gw :OpenDiagnostic<cr>

augroup diagnostic-nvim
    " this one is which you're most likely to use?
    autocmd!
    autocmd BufEnter * lua if jit ~= nil then require'diagnostic'.on_attach() end
augroup end
