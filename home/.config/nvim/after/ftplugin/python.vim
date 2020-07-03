set formatoptions-=t
if has('nvim-0.5')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    augroup cpp-fsync
        autocmd! BufWritePre <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup end
else
endif

let b:ale_linters = ['bandit', 'flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylama', 'pylint', 'vulture']
let b:ale_fixers = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let b:undo_ftplugin = '| setlocal omnifunc< | set formatoptions<'
