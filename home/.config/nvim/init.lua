if jit ~= nil then
    require'colorizer'.setup()
end

require'nvim_lsp'.bashls.setup{}
require'nvim_lsp'.clangd.setup{
    init_options = {
        semanticHighlighting = true
    }
}
require'nvim_lsp'.ccls.setup{
    init_options = {
        highlight = {
            lsRanges = true;
        }
  }
}
require'nvim_lsp'.jsonls.setup{}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.texlab.setup{}
require'nvim_lsp'.vimls.setup{}
-- require'nvim_lsp'.diagnosticls.setup{}
require'nvim_lsp'.html.setup{}
require'nvim_lsp'.cmake.setup{}

-- require'nvim-treesitter.configs'.setup {
--     highlight = {
--         enable = true,                    -- false will disable the whole extension
--         disable = {},        -- list of language that will be disabled
--     },
--     incremental_selection = {
--         enable = true,
--         disable = {},
--         keymaps = {                       -- mappings for incremental selection (visual mappings)
--           init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
--           node_incremental = "grn",       -- increment to the upper named parent
--           scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
--           node_decremental = "grm",      -- decrement to the previous node
--         }
--     },
--     ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
-- }
