if jit ~= nil then
    require'colorizer'.setup()
end

local lsp_status = require('lsp-status')

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}

lsp_status.register_progress()

local on_attach_vim = function(client)
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
  lsp_status.on_attach(client)
end

local lsp = require'nvim_lsp'

lsp.util.default_config = vim.tbl_extend(
    "force",
    lsp.util.default_config, {
        on_attach = on_attach_vim,
        capabilities = lsp_status.capabilities
    }
)

lsp.bashls.setup{}
lsp.clangd.setup{
    callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
        clangdFileStatus = true
    }
}
-- lsp.ccls.setup{
--     init_options = {
--         highlight = {
--             lsRanges = true;
--         },
--         client = {
--             snippetSupport = true
--         }
--     }
-- }
lsp.jsonls.setup{
    cmd = {"json-languageserver"};
}
lsp.pyls.setup{}
lsp.texlab.setup{}
lsp.vimls.setup{}
lsp.html.setup{}
lsp.cmake.setup{}
lsp.sumneko_lua.setup{
    cmd = {"lua-language-server"};
}

vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- for use with `formatexpr` if called without parms
-- @param start_line 1-indexed line
-- @param end_line 1-indexed line
-- @param timeout_ms optional
function Formatexpr(start_line, end_line, timeout_ms)
  if not start_line or not end_line then
    if vim.fn.mode() == 'i' or vim.fn.mode() == 'R' then
      -- `formatexpr` is also called when exceding
      -- `textwidth` in insert mode
      -- fall back to internal formatting
      return 1
    end
    start_line = vim.v.lnum
    end_line = start_line + vim.v.count - 1
  end
  if start_line > 0 and end_line > 0 then
    local params = {
      textDocument = { uri = vim.uri_from_bufnr(0) };
      range = {
        start = { line = start_line - 1; character = 0; };
        ["end"] = { line = end_line - 1; character = 0; };
      };
    };
    local result = vim.lsp.buf_request_sync(0, "textDocument/rangeFormatting", params, timeout_ms)
    if result then
      result = result[1].result
      vim.lsp.util.apply_text_edits(result)
    end
  end
 -- do not run builtin formatter.
  return 0
end

vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.Formatexpr')

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = {},        -- list of language that will be disabled
      custom_captures = {               -- mapping of user defined captures to highlight groups
        -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
      },
    },
    incremental_selection = {
      enable = true,
      disable = {},
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm",       -- decrement to the previous node
      }
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr"          -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",      -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD"      -- mapping to list all definitions in current file
        }
      }
    },
    textobjects = { -- syntax-aware textobjects
    enable = true,
    disable = {},
    keymaps = {
        ["iL"] = { -- you can define your own textobjects directly here
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function"
        },
        -- or you use the queries from supported languages with textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner"
      }
    },
    ensure_installed = "all" -- one of "all", "language", or a list of languages
}
