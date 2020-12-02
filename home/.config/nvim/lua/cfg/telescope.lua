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
