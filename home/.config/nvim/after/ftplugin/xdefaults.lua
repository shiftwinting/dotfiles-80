vim.bo.commentstring = "! %s"
require("agrp").set({
    xdefaults = { { "BufWritePost", "<buffer>", "!xrdb %" } },
})

vim.b.undo_ftplugin = vim.b.undo_ftplugin
    .. "| setlocal commentstring< | autocmd !xdefaults"
