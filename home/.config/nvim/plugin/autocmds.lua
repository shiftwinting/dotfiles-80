require("agrp").set({
    restore_pos = {
        {
            "BufReadPost",
            "* ++once",
            [[if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" |endif]],
        },
    },
    postwrite = {
        ["BufWritePost"] = {
            { "*.Xkeymap", "!xkbcomp % $DISPLAY" },
            { "*bspwmrc", "!bspc wm --restart" },
            { "*/polybar/config", "!polybar-msg cmd restart" },
            { "*user-dirs.dirs,*user-dirs.locale", "!xdg-user-dirs-update" },
        },
    },
    autocomplete = {
        { "CompleteDone", "*", "if pumvisible() == 0 | silent! pclose | endif" },
    },
    reload = {
        {
            "FocusGained,CursorHold,CursorHoldI",
            "?*",
            "if getcmdwintype() == '' | checktime | endif",
        },
    },
    terminsert = {
        {
            "TermOpen",
            "*",
            "startinsert",
        },
    },
    highlightyank = {
        { "TextYankPost", "*", vim.highlight.on_yank },
    },
    quitro = {
        {
            "VimEnter",
            "*",
            function()
                if vim.opt.readonly:get() then
                    vim.api.nvim_set_keymap("n", "q", "<Cmd>qa<CR>", {})
                end
            end,
        },
    },
    localinit = {
        {
            "VimEnter",
            "*",
            require"cfg.utils".sourceLocal,
        },
    },
})
