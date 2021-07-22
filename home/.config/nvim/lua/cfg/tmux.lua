require("tmux").setup({
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
    },
})

local map = require("mapper")

map.nlua("<c-h>", "require'tmux'.move_left()")
map.nlua("<c-j>", "require'tmux'.move_bottom()")
map.nlua("<c-k>", "require'tmux'.move_top()")
map.nlua("<c-l>", "require'tmux'.move_right()")

map.tlua("<c-h>", "require'tmux'.move_left()")
map.tlua("<c-j>", "require'tmux'.move_bottom()")
map.tlua("<c-k>", "require'tmux'.move_top()")
map.tlua("<c-l>", "require'tmux'.move_right()")
