if !g:use_plugins || exists('g:loaded_nvim_lsp_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_nvim_lsp_config = 1

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gpd <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> gtd   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gS    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gic    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> goc    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.formatting()<CR>
xnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent> gca    <cmd>lua vim.lsp.buf.code_action()<CR>
