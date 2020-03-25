if !g:use_plugins || exists('g:loaded_nvim_lsp_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_nvim_lsp_config = 1

if executable('bash-language-server')
lua <<
require'nvim_lsp'.bashls.setup{on_attach=require'completion'.on_attach}
.
endif
if executable('ccls')
lua <<
require'nvim_lsp'.ccls.setup{on_attach=require'completion'.on_attach,
  init_options = {
    highlight = {
      lsRanges = true;
    }
  }
}
.
endif
if executable('clangd')
lua <<
require'nvim_lsp'.clangd.setup{on_attach=require'completion'.on_attach}
.
endif
if executable('jsonls')
lua <<
require'nvim_lsp'.jsonls.setup{on_attach=require'completion'.on_attach}
.
endif
if executable('pyls')
lua <<
require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
.
endif
if executable('texlab')
lua <<
require'nvim_lsp'.texlab.setup{on_attach=require'completion'.on_attach}
.
endif
lua <<
require'nvim_lsp'.vimls.setup{on_attach=require'completion'.on_attach}
.

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
