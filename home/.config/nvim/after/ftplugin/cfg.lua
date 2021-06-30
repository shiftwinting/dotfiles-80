vim.bo.commentstring = "// %s"
require("agrp").set({
    dunst = { { "BufWritePost", "*dunstrc", "!killall -SIGUSR2 dunst" } },
})

vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| setlocal commentstring< | autocmd !dunst"
