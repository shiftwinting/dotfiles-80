require("gitsigns").setup({
    signs = {
        change = { show_count = true },
        delete = { show_count = true },
        topdelete = { show_count = true },
        changedelete = { show_count = true },
    },
    word_diff = true,
    -- current_line_blame = true
})
