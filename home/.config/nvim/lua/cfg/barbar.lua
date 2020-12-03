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
    maximum_padding = 0
}

local barbar_map = function(keys, func)
    vim.api.nvim_set_keymap('n', keys, ":" .. func .. "<cr>",
                            {noremap = true, silent = true})
end
-- Magic buffer-picking mode
barbar_map('<leader>bp', 'BufferPick')
-- -- Move to previous/next
barbar_map('<A-,>', 'BufferPrevious')
barbar_map('<A-.>', 'BufferNext')
-- -- Re-order to previous/next
-- barbar_map('<A-<, 'BufferMovePrevious')
-- barbar_map('<A->, 'BufferMoveNext')
-- Goto buffer in position...
barbar_map('<A-1>', 'BufferGoto 1')
barbar_map('<A-2>', 'BufferGoto 2')
barbar_map('<A-3>', 'BufferGoto 3')
barbar_map('<A-4>', 'BufferGoto 4')
barbar_map('<A-5>', 'BufferGoto 5')
barbar_map('<A-6>', 'BufferGoto 6')
barbar_map('<A-7>', 'BufferGoto 7')
barbar_map('<A-8>', 'BufferGoto 8')
barbar_map('<A-9>', 'BufferLast')
-- Close buffer
barbar_map('<A-c>', 'BufferClose')
-- Wipeout buffer
-- :BufferWipeout
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
