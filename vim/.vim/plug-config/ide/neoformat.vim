if !g:use_plugins || !g:is_ide || exists('g:loaded_neoformat_config')
    finish
endif
let g:loaded_neoformat_config = 1

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
