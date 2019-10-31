if !g:use_plugins || exists('g:loaded_lsp_config')
    finish
endif
let g:loaded_lsp_config = 1

if executable('clangd')
    augroup clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
    augroup END
endif
" if executable('ccls')
"     augroup ccls
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"             \ 'name': 'ccls',
"             \ 'cmd': {server_info->['ccls']},
"             \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"             \ 'initialization_options': {},
"             \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"             \ })
"     augroup END
" endif
if executable('cquery')
    augroup cquery
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
    augroup END
endif

if executable('pyls')
    augroup pyls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
        autocmd Filetype python setlocal omnifunc=lsp#complete
    augroup END
endif

if executable('bash-language-server')
    augroup bash_ls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                \ 'name': 'bash-language-server',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
                \ 'whitelist': ['sh'],
                \ })
        autocmd Filetype sh setlocal omnifunc=lsp#complete
    augroup END
endif

let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0
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
nmap <silent> gi <Plug>(lsp-implementation)
nmap <silent> gr <Plug>(lsp-references)
nmap <silent> gh <Plug>(lsp-hover)
nmap <leader> gr <Plug>(lsp-rename)

xmap <leader>f  <Plug>(lsp-document-format)
nmap <leader>f  <Plug>(lsp-document-format)
xmap <leader>a  <Plug>(lsp-codeaction-selected)
nmap <leader>a  <Plug>(lsp-codeaction)