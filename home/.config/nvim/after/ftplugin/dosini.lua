require("agrp").set({
    editorconfig = { { "BufWritePost", "*.editorconfig", "EditorConfigReload" } },
})
vim.b.undo_ftplugin = "| autocmd !editorconfig"
