require('telescope').setup {
    defaults = {
        color_devicons = false,
        prompt_position = "top",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        generic_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_sorter = require'telescope.sorters'.get_fzy_sorter
    }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('dap')

local telescope_map = function(keys, func, mod)
    mod = mod or '.builtin'
    vim.api.nvim_set_keymap('n', '<localleader>' .. keys,
                            ":lua require'telescope." .. mod .. "'." .. func ..
                                "<cr>", {silent = true})
end

telescope_map('p', 'planets()')
telescope_map('B', 'builtin()')

telescope_map('/', 'live_grep()')
telescope_map('?', 'grep_string()')
telescope_map('f',
              'find_files{find_command = {"fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git"}}')
telescope_map('b', 'buffers{show_all_buffers = true}')

telescope_map('t', 'treesitter()')

telescope_map('s', 'lsp_document_symbols()')
telescope_map('S', 'lsp_workspace_symbols()')
telescope_map('r', 'lsp_references()')
telescope_map('a', 'lsp_code_actions()')
telescope_map('A', 'lsp_range_code_actions()')

telescope_map('c', 'commands()')
telescope_map('h', 'help_tags()')
telescope_map('m', 'man_pages()')
telescope_map('k', 'keymaps()')
telescope_map('Q', 'quickfix()')
telescope_map('L', 'loclist()')
telescope_map('R', 'registers()')
telescope_map('A', 'autocommands()')

telescope_map('gs', 'git_status()')
telescope_map('gb', 'git_branches()')
telescope_map('gc', 'git_commits()')
telescope_map('gC', 'git_bcommits()')

telescope_map('dc', "extensions.dap.commands()", "")
telescope_map('dC', "extensions.dap.configurations()", "")
telescope_map('db', "extensions.dap.list_breakpoints()", "")
telescope_map('dv', "extensions.dap.variables()", "")
