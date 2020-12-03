require("completion").addCompletionSource("vimtex",
                                          require("cfg.vimtex").complete_item)
vim.g.completion_enable_snippet = 'UltiSnips'
-- vim.g.completion_matching_ignore_case = 1
vim.g.completion_auto_change_source = 1
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
vim.g.completion_enable_auto_paren = 1
vim.g.completion_trigger_on_delete = 1
vim.g.completion_confirm_key = ""

vim.g.completion_chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp', 'snippet'}}, {complete_items = {'ts'}}
        },
        string = {
            {complete_items = {'path'}, triggered_only = {'/'}},
            {complete_items = {'buffers'}}
        },
        comment = {{complete_items = {'buffers', 'path'}}}
    },
    tex = {
        default = {
            {complete_items = {'vimtex', 'lsp', 'snippet'}},
            {complete_items = {'ts'}}, {complete_items = {'buffers'}}
        },
        comment = {{complete_items = {'buffers'}}}
    }
}

local imap = function(keys, action)
    vim.api.nvim_set_keymap('i', keys, action, {silent = true})
end

imap("<c-j>", "<Plug>(completion_next_source)")
imap("<c-k>", "<Plug>(completion_prev_source)")
imap("<tab>", "<Plug>(completion_smart_tab)")
imap("<s-tab>", "<Plug>(completion_smart_s_tab)")

vim.api.nvim_set_keymap('i', "<cr>",
                        "pumvisible() ? complete_info()['selected'] != '-1' ? '<Plug>(completion_confirm_completion)'  : '<c-e><CR>' : '<CR>'",
                        {silent = true, expr = true})
