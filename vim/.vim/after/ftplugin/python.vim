if executable('pyls')
    setlocal omnifunc=lsp#complete
endif
let b:ale_linters = ['bandit', 'flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylama', 'pyls', 'pyre', 'vulture']
let b:ale_fixers = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin = '| setlocal omnifunc<'
