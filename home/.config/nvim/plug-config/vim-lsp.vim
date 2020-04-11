if !g:use_plugins || exists('g:loaded_vim_lsp_config') || has('nvim-0.5')
    finish
endif
let g:loaded_vim_lsp_config = 1

if executable('ccls')
    augroup ccls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                \   'name': 'ccls',
                \   'cmd': {server_info-> ['ccls']},
                \   'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                \   'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
                \   'initialization_options': {
                \       'cache': {'directory' : '/tmp/ccls_cache/cache'},
                \       'completion': {'detailedLabel': v:false},
                \       'highlight': { 'lsRanges' : v:true },
                \   }
                \ })
    augroup END
elseif executable('cquery')
    augroup cquery
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {
        \   'cacheDirectory': '/tmp/cquery/cache',
        \   'highlight': { 'enabled' : v:true },
        \   'emitInactiveRegions': v:true,
        },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
    augroup END
endif

let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_async_completion=1

" Remap keys for gotos
nmap <silent> gd <Plug>(lsp-peek-definition)
nmap <silent> gD <Plug>(lsp-definition)
nmap <silent> ge <Plug>(lsp-peek-declaration)
nmap <silent> gE <Plug>(lsp-declaration)
nmap <silent> gy <Plug>(lsp-peek-type-definition)
nmap <silent> gY <Plug>(lsp-type-definition)
nmap <silent> gi <Plug>(lsp-peek-implementation)
nmap <silent> gI <Plug>(lsp-implementation)
nmap <silent> gr <Plug>(lsp-references)
nmap <silent> gh <Plug>(lsp-hover)
nmap <silent> gR <Plug>(lsp-rename)

xmap <leader>f  <Plug>(lsp-document-format)
nmap <leader>f  <Plug>(lsp-document-format)
xmap <leader>a  <Plug>(lsp-codeaction-selected)
nmap <leader>a  <Plug>(lsp-codeaction)
