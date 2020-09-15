if !g:use_plugins || exists('g:loaded_lsp_status_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_lsp_status_config = 1

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

set statusline+=%=%{LspStatus()}
