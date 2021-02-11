require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = false,
        nvim_lsp = true,
        nvim_lua = false,
        spell = true,
        tags = false,
        snippets_nvim = false,
        treesitter = true
    }
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end
_G.cr_complete = function()
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()['selected'] ~= -1 then
          return vim.fn['compe#configrm']('<CR>')
        else
          return t "<c-e><CR>"
        end
    else
        return t "<CR>"
    end
end

local map = require "mapper"

map.ilua("<tab>", "tab_complete()")
map.ilua("<s-tab>", "s_tab_complete()")
map.ilua("<cr>", "cr_complete()")

--[[ require("completion").addCompletionSource("vimtex",
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
            {complete_items = {'path'}, triggered_only = {'/'}}
            -- {complete_items = {'buffers'}}
        },
        comment = {{complete_items = {'buffers', 'path'}}}
    },
    tex = {
        default = {
            {complete_items = {'vimtex', 'lsp', 'snippet'}},
            {complete_items = {'ts'}}
            -- {complete_items = {'buffers'}}
        }
        -- comment = {{complete_items = {'buffers'}}}
    }
}

local map = require "mapper"

map.iplug("<c-j>", "completion_next_source")
map.iplug("<c-k>", "completion_prev_source")
map.iplug("<tab>", "completion_smart_tab")
map.iplug("<s-tab>", "completion_smart_s_tab")

map.i("<cr>",
      "pumvisible() ? complete_info()['selected'] != '-1' ? '<Plug>(completion_confirm_completion)'  : '<c-e><CR>' : '<CR>'",
      false, {expr = true}) ]]
