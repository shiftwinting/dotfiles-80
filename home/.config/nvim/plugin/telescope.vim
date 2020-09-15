if !g:use_plugins || exists('g:loaded_telescope_config')
    finish
endif
let g:loaded_telescope_config = 1

nnoremap <silent><localleader>r :lua require'telescope.builtin'.lsp_references()<cr>
nnoremap <silent><localleader>p :lua require'telescope.builtin'.planets()<cr>
nnoremap <silent><localleader>t :lua require'telescope.builtin'.treesitter()<cr>
nnoremap <silent><localleader>s :lua require'telescope.builtin'.workspace_symbols()<cr>
nnoremap <silent><localleader>g :lua require'telescope.builtin'.live_grep()<cr>
nnoremap <silent><localleader>f :lua require'telescope.builtin'.find_files{find_command = {"fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git"}}<cr>
nnoremap <silent><localleader>b :lua require'telescope.builtin'.buffers()<cr>
