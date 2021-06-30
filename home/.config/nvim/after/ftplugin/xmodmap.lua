require("agrp").set({
    xmodmap = { { "BufWritePost", "<buffer>", "!xmodmap %" } },
})

vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| autocmd !xmodmap"
