if exists('g:loaded_telescope_config')
    finish
endif
let g:loaded_telescope_config = 1

nnoremap <silent><localleader>p :lua require'telescope.builtin'.planets()<cr>
nnoremap <silent><localleader>B :lua require'telescope.builtin'.builtin()<cr>

nnoremap <silent><localleader>g :lua require'telescope.builtin'.live_grep()<cr>
nnoremap <silent><localleader>G :lua require'telescope.builtin'.grep_string()<cr>
nnoremap <silent><localleader>f :lua require'telescope.builtin'.find_files{find_command = {"fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git"}}<cr>
nnoremap <silent><localleader>b :lua require'telescope.builtin'.buffers{show_all_buffers = true}<cr>

nnoremap <silent><localleader>t :lua require'telescope.builtin'.treesitter()<cr>

nnoremap <silent><localleader>s :lua require'telescope.builtin'.lsp_document_symbols()<cr>
nnoremap <silent><localleader>S :lua require'telescope.builtin'.lsp_workspace_symbols()<cr>
nnoremap <silent><localleader>r :lua require'telescope.builtin'.lsp_references()<cr>
nnoremap <silent><localleader>a :lua require'telescope.builtin'.lsp_code_actions()<cr>
nnoremap <silent><localleader>A :lua require'telescope.builtin'.lsp_range_code_actions()<cr>

nnoremap <silent><localleader>c :lua require'telescope.builtin'.commands()<cr>
nnoremap <silent><localleader>h :lua require'telescope.builtin'.help_tags()<cr>
nnoremap <silent><localleader>m :lua require'telescope.builtin'.man_pages()<cr>
nnoremap <silent><localleader>k :lua require'telescope.builtin'.keymaps()<cr>
nnoremap <silent><localleader>Q :lua require'telescope.builtin'.quickfix()<cr>
nnoremap <silent><localleader>L :lua require'telescope.builtin'.loclist()<cr>
nnoremap <silent><localleader>R :lua require'telescope.builtin'.registers()<cr>
