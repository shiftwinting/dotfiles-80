vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_progname = 'nvr'
vim.g.vimtex_format_enabled = 1
vim.g.vimtex_quickfix_autojump = 1
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_complete_img_use_tail = 1
vim.g.vimtex_compiler_latexmk = {callback = 0}

local M = {}

function M.getCompletionItems(prefix)
    local items = vim.api.nvim_call_function('vimtex#complete#omnifunc',
                                             {0, prefix})
    return items
end

M.complete_item = {item = M.getCompletionItems}

return M
