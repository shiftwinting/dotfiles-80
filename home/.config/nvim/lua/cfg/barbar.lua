-- NOTE: This variable doesn't exist before barbar runs. Create it before
--       setting any option.
vim.g.bufferline = {
    -- Enable/disable animations
    animation = false,
    -- Enable/disable icons
    -- if set to "numbers", will show buffer index in the tabline
    icons = "numbers",
    -- Enable/disable close button
    closable = false,
    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = false,
    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    -- semantic_letters = true,
    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    -- letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 0,
}

local map = require("mapper")
-- Magic buffer-picking mode
map.ncmd("<leader>bp", "BufferPick")
-- -- Move to previous/next
map.ncmd("<A-,>", "BufferPrevious")
map.ncmd("<A-.>", "BufferNext")
-- -- Re-order to previous/next
-- map.ncmd('<A-<, 'BufferMovePrevious')
-- map.ncmd('<A->, 'BufferMoveNext')
-- Goto buffer in position...
map.ncmd("<A-1>", "BufferGoto 1")
map.ncmd("<A-2>", "BufferGoto 2")
map.ncmd("<A-3>", "BufferGoto 3")
map.ncmd("<A-4>", "BufferGoto 4")
map.ncmd("<A-5>", "BufferGoto 5")
map.ncmd("<A-6>", "BufferGoto 6")
map.ncmd("<A-7>", "BufferGoto 7")
map.ncmd("<A-8>", "BufferGoto 8")
map.ncmd("<A-9>", "BufferLast")
-- Close buffer
map.ncmd("<A-c>", "BufferClose")
-- Wipeout buffer
-- :BufferWipeout
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
