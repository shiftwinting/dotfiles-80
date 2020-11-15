require"plugins"
require"colorizer".setup()
require "nvim_utils"

-- for use with `formatexpr` if called without parms
-- @param start_line 1-indexed line
-- @param end_line 1-indexed line
-- @param timeout_ms optional
function Formatexpr(start_line, end_line, timeout_ms)
    timeout_ms = timeout_ms or 500

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
            textDocument = vim.lsp.util.make_text_document_params(),
            range = {
                start = {line = start_line - 1, character = 0},
                ["end"] = {line = end_line - 1, character = 0}
            }
        };
        local client_results = vim.lsp.buf_request_sync(0,
                                                        "textDocument/rangeFormatting",
                                                        params, timeout_ms)

        -- Apply the text edits from one and only one of the clients.
        for _, response in pairs(client_results) do
            if response.result then
                vim.lsp.util.apply_text_edits(response.result, 0)
                return 0
            end
        end
    end

    -- do not run builtin formatter.
    return 0
end

require("completion").addCompletionSource("vimtex",
                                          require("vimtex").complete_item)

local mapper = function(keys, action)
    vim.api.nvim_buf_set_keymap(0, 'n', keys, action,
                                {noremap = true, silent = true})
end

local on_attach_wrapper = function(client)
    require"completion".on_attach(client)
    mapper('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('gD', '<cmd>lua vim.lsp.declaration()<CR>')
    mapper('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('<leader>gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    mapper('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    mapper('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    mapper('gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('gic', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    mapper('goc', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
    mapper('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    mapper('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
    mapper('<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    mapper('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    mapper('gw', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    mapper('gW', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    mapper('[w', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    mapper(']w', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    mapper('[e',
           '<cmd>lua vim.lsp.diagnostic.goto_prev { severity_limit = "Error" }<CR>')
    mapper(']e',
           '<cmd>lua vim.lsp.diagnostic.goto_next { severity_limit = "Error" }<CR>')
    vim.api.nvim_buf_set_keymap(0, 'x', '<leader>f',
                                '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
                                {noremap = true, silent = true})
    -- annoying diagnostics
    -- vim.api
    --     .nvim_command [[autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.util.show_line_diagnostics()]]

    -- lsp highlighting
    -- vim.api
    --     .nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    -- vim.api
    --     .nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    -- vim.api
    --     .nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

    -- auto format on save
    -- vim.api
    --     .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    nvim.bo.formatexpr = "v:lua.Formatexpr"
    nvim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end

local lspconfig = require "lspconfig"

lspconfig.util.default_config = vim.tbl_extend("force",
                                               lspconfig.util.default_config, {
    on_attach = on_attach_wrapper
    -- capabilities = lsp_status.capabilities
})
lspconfig.bashls.setup {}
lspconfig.clangd.setup {
    cmd = {
        "clangd", "--background-index", "--clang-tidy",
        "--completion-style=bundled", "--header-insertion=iwyu",
        "--header-insertion-decorators", "--suggest-missing-includes",
        "--cross-file-rename", "--index"
        -- '--all-scopes-completion',
    },
    -- callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {
        usePlaceholders = true,
        completeUnimported = true
        -- clangdFileStatus = true
    }
}
-- lsp_cfg.ccls.setup {
--     init_options = {
--         highlight = {lsRanges = true},
--         client = {snippetSupport = true}
--     }
-- }
lspconfig.jsonls.setup {cmd = {"json-languageserver"}}
lspconfig.pyls.setup {}
lspconfig.texlab.setup {}
lspconfig.vimls.setup {}
lspconfig.html.setup {}
lspconfig.cmake.setup {}
lspconfig.cssls.setup {}
lspconfig.yamlls.setup {}

local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/";
        if vim.fn.isdirectory(lua_path) then result[lua_path] = true end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true
    return result;
end

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
                -- TODO: Figure out how to get plugins here.
                -- path = vim.split(package.path, ';')
                -- path = {package.path},
            },
            completion = {
                -- You should use real snippets
                keywordSnippet = "Disable"
            },
            diagnostics = {
                enable = true,
                globals = {
                    -- Neovim
                    "vim", -- Busted
                    "describe", "it", "before_each", "after_each", "teardown",
                    "pending"
                }
            },

            workspace = {
                library = get_lua_runtime(),
                maxPreload = 1000,
                preloadFileSize = 1000
            }
        }
    },

    filetypes = {"lua"},
    cmd = {"lua-language-server"}
})

lspconfig.efm.setup {
    filetypes = {
        "vim", "make", "markdown", "rst", "yaml", "python", "sh", "html",
        "json", "csv", "lua"
    }
}

local tsconfigs = require "nvim-treesitter.configs"

tsconfigs.setup {
    ensure_installed = "all", -- one of "all", "language", or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        use_language_tree = true,
        disable = {} -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {enable = true},
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = true},
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>"
            }
        }
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function"
                }
            }
        },
        swap = {
            enable = true,
            swap_next = {["<leader>a"] = "@parameter.inner"},
            swap_previous = {["<leader>A"] = "@parameter.inner"}
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer"
            }
        }
    },
    rainbow = {
        enable = false,
        disable = {'lua', 'bash'} -- please disable lua and bash for now
    }
}

local dap = require "dap"
dap.adapters.lldb = {
    type = "executable",
    attach = {pidProperty = "pid", pidSelect = "ask"},
    command = "lldb-vscode",
    env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"},
    name = "lldb"
}

local FindPython = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. "/venv/bin/python") then
        return cwd .. "/venv/bin/python"
    elseif vim.fn.executable(cwd .. "/.venv/bin/python") then
        return cwd .. "/.venv/bin/python"
    else
        return "/usr/bin/python"
    end
end

dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python",
    args = {"-m", "debugpy.adapter"}
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = FindPython()
    }
}

dap.repl.commands = {
    continue = {".continue", ".c"},
    next_ = {".next", ".n"},
    into = {".into"},
    out = {".out"},
    scopes = {".scopes"},
    threads = {".threads"},
    frames = {".frames"},
    exit = {"exit", ".exit"},
    up = {".up"},
    down = {".down"},
    goto_ = {".goto"},
    capabilities = {".capabilities"},
    -- add your own commands
    custom_commands = {[".echo"] = function(text) dap.repl.append(text) end}
}

vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "dap-cfg".start_c_debugger({<f-args>})
]]

vim.g.dap_virtual_text = 'all frames'

vim.lsp.handlers['textDocument/codeAction'] =
    require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] =
    require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] =
    require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] =
    require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] =
    require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] =
    require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] =
    require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] =
    require'lsputil.symbols'.workspace_handler

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true
    })

require('telescope').setup {
    defaults = {
        generic_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_sorter = require'telescope.sorters'.get_fzy_sorter
    }
}

require('gitsigns').setup {
    signs = {
        add = {hl = 'DiffAdd', text = '│'},
        change = {hl = 'DiffChange', text = '│'},
        delete = {hl = 'DiffDelete', text = '_'},
        topdelete = {hl = 'DiffDelete', text = '‾'},
        changedelete = {hl = 'DiffChange', text = '~'}
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
        },
        ['n [c'] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
        },

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>'
    },
    watch_index = {interval = 1000},
    sign_priority = 6
}

-- require('indent_guides').default_opts = {
--     indent_levels = 30,
--     indent_guide_size = 0,
--     indent_start_level = 1,
--     indent_space_guides = true,
--     indent_tab_guides = true,
--     indent_pretty_guides = false,
--     indent_soft_pattern = '\\s',
--     exclude_filetypes = {'help', 'man'},
--     -- TODO add rainbow mode support just like vscode
--     indent_rainbow_mode = false
-- }
