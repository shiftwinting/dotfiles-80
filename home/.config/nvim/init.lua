if jit ~= nil then
    require'colorizer'.setup()
end

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local on_attach_vim = function()
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
  lsp_status.on_attach()
end

require'nvim_lsp'.bashls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.clangd.setup{
    callbacks = lsp_status.extensions.clangd.setup(),
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities,
    init_options = {
        semanticHighlighting = true,
        clangdFileStatus = true
    }
}
require'nvim_lsp'.ccls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities,
    init_options = {
        highlight = {
            lsRanges = true;
        }
  }
}
require'nvim_lsp'.jsonls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.pyls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.texlab.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.vimls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.diagnosticls.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.html.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}
require'nvim_lsp'.cmake.setup{
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities
}

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
