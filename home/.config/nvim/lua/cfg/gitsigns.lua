require('gitsigns').setup {
    signs = {
        add = {hl = 'DiffAdd', text = '│'},
        change = {hl = 'DiffChange', text = '│'},
        delete = {hl = 'DiffDelete', text = '_', show_count = true},
        topdelete = {hl = 'DiffDelete', text = '‾', show_count = true},
        changedelete = {hl = 'DiffChange', text = '~', show_count = true}
    },
    count_chars = {
        [1] = '1', -- '₁',
        [2] = '2', -- '₂',
        [3] = '3', -- '₃',
        [4] = '4', -- '₄',
        [5] = '5', -- '₅',
        [6] = '6', -- '₆',
        [7] = '7', -- '₇',
        [8] = '8', -- '₈',
        [9] = '9', -- '₉',
        ['+'] = '' -- '₊',
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
        },
        ['n [c'] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
        },

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_index = {interval = 1000},
    sign_priority = 6,
    status_formatter = function(status)
        local status_txt = status.head
        if status.added > 0 then
            status_txt = status_txt .. '+' .. status.added
        end
        if status.changed > 0 then
            status_txt = status_txt .. '~' .. status.changed
        end
        if status.removed > 0 then
            status_txt = status_txt .. '-' .. status.removed
        end
        return status_txt
    end

}
