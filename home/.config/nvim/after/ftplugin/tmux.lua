require("agrp").set({
    tmux = { { "BufWritePost", "<buffer>", "make" } },
})
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| autocmd !tmux"
