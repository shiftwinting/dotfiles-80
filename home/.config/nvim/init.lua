if jit ~= nil then
    require'colorizer'.setup()
end

-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

local on_attach_vim = function()
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
  -- lsp_status.on_attach()
end

local lsp = require'nvim_lsp'

lsp.util.default_config = vim.tbl_extend(
    "force",
    lsp.util.default_config, {
        on_attach = on_attach_vim
    }
)

lsp.bashls.setup{}
lsp.clangd.setup{
    -- callbacks = lsp_status.extensions.clangd.setup(),
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                snippetSupport = true
                }
            }
        }
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
        clangdFileStatus = true
    }
}
lsp.ccls.setup{
    init_options = {
        highlight = {
            lsRanges = true;
        },
        client = {
            snippetSupport = true
        }
    }
}
lsp.jsonls.setup{}
lsp.pyls.setup{}
lsp.texlab.setup{}
lsp.vimls.setup{
   capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  } 
}
lsp.html.setup{}
lsp.cmake.setup{}

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,                    -- false will disable the whole extension
        disable = {},        -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {                       -- mappings for incremental selection (visual mappings)
          init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
          node_incremental = "grn",       -- increment to the upper named parent
          scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "grm",       -- decrement to the previous node
        }
    },
    refactor = {
      highlight_defintions = {
        enable = true
      },
      smart_rename = {
        enable = true,
        smart_rename = "grr"              -- mapping to rename reference under cursor
      },
      navigation = {
        enable = true,
        goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
        list_definitions = "gnD"          -- mapping to list all definitions in current file
      }
    },
    ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
