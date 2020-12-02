require('indent_guides').options = {
    indent_levels = 20,
    indent_guide_size = 0,
    indent_start_level = 1,
    indent_space_guides = true,
    indent_tab_guides = true,
    indent_soft_pattern = '\\s',
    exclude_filetypes = {
        'help', 'man', 'terminal', 'packer', 'TelescopePrompt', 'fugitive',
        'diff'
    },
    -- TODO add rainbow mode support just like vscode
    indent_rainbow_mode = false
}
