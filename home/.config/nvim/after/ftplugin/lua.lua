require("agrp").set({
    packer_compile = {
        {
            "BufWritePost",
            "plugins.lua",
            "PackerSync",
        },
    },
})

vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| autocmd! packer_compile"
