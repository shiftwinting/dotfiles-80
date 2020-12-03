vim.g.qf_shorten_path = 0

vim.api.nvim_set_keymap('n', '<localleader>q', '<Plug>(qf_qf_toggle_stay)', {silent = true})
vim.api.nvim_set_keymap('n', '<localleader>l', '<Plug>(qf_loc_toggle_stay)', {silent = true})
