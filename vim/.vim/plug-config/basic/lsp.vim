if !g:use_plugins || !g:is_ide || exists('g:loaded_lsp_config')
    finish
endif
let g:loaded_lsp_config = 1

if executable('ccls')
    augroup ccls
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'ccls',
            \ 'cmd': {server_info->['ccls']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            \ 'initialization_options': {},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ })
        autocmd Filetype c,cpp setlocal omnifunc=lsp#complete
    augroup END
endif

if executable('clangd')
    augroup clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
        autocmd Filetype c,cpp setlocal omnifunc=lsp#complete
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
        " autocmd Filetype sh let b:vcm_tab_complete="omni"
    augroup END
endif

let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_highlight_references_enabled = 1
let g:lsp_async_completion=1

" Remap keys for gotos
nmap <silent> gd <Plug>(lsp-definition)
nmap <silent> ge <Plug>(lsp-declaration)
nmap <silent> gy <Plug>(lsp-type-definition)
nmap <silent> gi <Plug>(lsp-implementation)
nmap <silent> gr <Plug>(lsp-references)
nmap <silent> gh <Plug>(lsp-hover)
" Remap for rename current word
nmap <leader> rn <Plug>(lsp-rename)

" " Remap for format selected region
xmap <leader>f  <Plug>(lsp-document-format)
nmap <leader>f  <Plug>(lsp-document-format)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(lsp-codeaction-selected)
nmap <leader>a  <Plug>(lsp-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(lsp-code-action)
