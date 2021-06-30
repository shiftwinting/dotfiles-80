require("agrp").set({
    fontconf = { { "BufWritePost", "*fonts.conf", "!fc-cache" } },
})

vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| autocmd !fontconf"
