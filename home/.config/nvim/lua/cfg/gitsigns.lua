require('gitsigns').setup {
    use_decoration_api = true,
    signs = {
        change = {show_count = true},
        delete = {show_count = true},
        topdelete = {show_count = true},
        changedelete = {show_count = true}
    }
}
