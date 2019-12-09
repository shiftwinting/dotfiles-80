set formatoptions-=t
let b:ale_linters = ['pycodestyle', 'pyflakes', 'pyls']
let b:ale_fixers = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin = '| setlocal omnifunc< | set formatoptions<'
