require("agrp").set({
    sxhkdrc = { { "BufWritePost", "<buffer>", "!pkill -SIGUSR1 sxhkd" } },
})
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| autocmd !sxhkdrc"
