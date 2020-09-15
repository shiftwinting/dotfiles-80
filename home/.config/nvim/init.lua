require"colorizer".setup()
require "nvim_utils"

local lsp_status = require("lsp-status")

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

require("completion").addCompletionSource("vimtex",
                                          require("vimtex").complete_item)

local on_attach_wrapper = function(client)
    require"completion".on_attach(client)
    require"diagnostic".on_attach(client)
    lsp_status.on_attach(client)
    vim.api.nvim_command(
        "autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.util.show_line_diagnostics()")
end

local lsp_cfg = require "nvim_lsp"

lsp_cfg.util.default_config = vim.tbl_extend("force",
                                             lsp_cfg.util.default_config, {
    on_attach = on_attach_wrapper,
    capabilities = lsp_status.capabilities
})
lsp_cfg.bashls.setup {}
lsp_cfg.clangd.setup {
    cmd = {
        "clangd", "--background-index", "--clang-tidy",
        "--completion-style=bundled", "--header-insertion=iwyu",
        "--header-insertion-decorators", "--suggest-missing-includes",
        "--cross-file-rename", "--index"
        -- '--all-scopes-completion',
    },
    callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true
    }
}
lsp_cfg.ccls.setup {
    init_options = {
        highlight = {lsRanges = true},
        client = {snippetSupport = true}
    }
}
lsp_cfg.jsonls.setup {cmd = {"json-languageserver"}}
lsp_cfg.pyls.setup {}
lsp_cfg.texlab.setup {}
lsp_cfg.vimls.setup {}
lsp_cfg.html.setup {}
lsp_cfg.cmake.setup {}
require('nlua.lsp').set_lsp(lsp_cfg)

lsp_cfg.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                -- TODO: Figure out how to get plugins here.
                path = vim.split(package.path, ';')
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
                library = {
                    -- This loads the `lua` files from nvim into the runtime.
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true
                }
            }
        }
    },

    filetypes = {"lua"},
    cmd = {"lua-language-server"}
})

-- require'nvim_lsp'.efm.setup {
--     filetypes = {"vim", "markdown", "rst", "sh", "json", "html", "lua"}
-- }

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
            textDocument = {uri = vim.uri_from_bufnr(0)},
            range = {
                start = {line = start_line - 1, character = 0},
                ["end"] = {line = end_line - 1, character = 0}
            }
        };
        local result = vim.lsp.buf_request_sync(0,
                                                "textDocument/rangeFormatting",
                                                params, timeout_ms)
        if result then
            result = result[1].result
            vim.lsp.util.apply_text_edits(result)
        end
    end
    -- do not run builtin formatter.
    return 0
end

vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.Formatexpr")

local ts_cfg = require "nvim-treesitter.configs"

ts_cfg.setup {
    ensure_installed = "all", -- one of "all", "language", or a list of languages
    highlight = {
        enable = false, -- false will disable the whole extension
        disable = {"css"} -- list of language that will be disabled
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
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = true},
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
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
        }
    }
}

local dap = require "dap"
dap.adapters.cpp = {
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
    command! -complete=file -nargs=* DebugC lua require "dap-cfg".start_c_debugger({<f-args>}, "lldb-vscode")
]]

vim.g.dap_virtual_text = true
