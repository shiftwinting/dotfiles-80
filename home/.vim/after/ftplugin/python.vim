set formatoptions-=t
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
let b:ale_linters = ['pycodestyle', 'pyflakes']
let b:ale_fixers = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin = '| setlocal omnifunc< | set formatoptions<'
