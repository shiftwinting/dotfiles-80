require("compe").setup({
    source = {
        path = true,
        buffer = false,
        calc = false,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = false,
        spell = true,
        tags = false,
        snippets_nvim = false,
        treesitter = false,
    },
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-n>")
    elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    elseif check_back_space() then
        return t("<Tab>")
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-p>")
    elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
        return t("<Plug>(vsnip-jump-prev)")
    else
        return t("<S-Tab>")
    end
end

_G.cr_complete = function()
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        else
            return t("<c-e><CR>")
        end
    else
        return t("<CR>")
    end
end

local map = require("mapper")

map.ilua("<tab>", "tab_complete()")
map.ilua("<s-tab>", "s_tab_complete()")
map.ilua("<cr>", "cr_complete()")
