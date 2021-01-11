local map = require "mapper"
local lspconfig = require "lspconfig"
local lsputil = lspconfig.util

local on_attach_wrapper = function(client, bufnr, user_opts)
    local opts = user_opts or
                     {
            auto_format = false,
            show_diags = false,
            lsp_highlights = false
        }
    local auto_format = opts.auto_format or false
    local show_diags = opts.show_diags or false
    local lsp_highlights = opts.lsp_highlights or false

    local lsp_nmap = function(keys, func)
        map.nlua(keys, "vim.lsp." .. func, bufnr)
    end
    local lsp_vmap = function(keys, func)
        map.vlua(keys, "vim.lsp." .. func, bufnr)
    end

    local function lsp_setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end

    require"completion".on_attach(client)

    lsp_nmap('K', 'buf.hover()')
    lsp_nmap('<c-]>', 'buf.definition()')
    lsp_nmap('gD', 'buf.declaration()')
    lsp_nmap('gd', 'buf.definition()')
    lsp_nmap('<leader>gd', 'buf.type_definition()')
    lsp_nmap('gi', 'buf.implementation()')
    lsp_nmap('gs', 'buf.signature_help()')
    lsp_nmap('gh', 'buf.hover()')
    lsp_nmap('gic', 'buf.incoming_calls()')
    lsp_nmap('goc', 'buf.outgoing_calls()')
    lsp_nmap('gr', 'buf.references()')
    lsp_nmap('gR', 'buf.rename()')
    lsp_nmap('ga', 'buf.code_action()')
    lsp_nmap('gw', 'diagnostic.show_line_diagnostics()')
    lsp_nmap('gW', 'diagnostic.set_loclist()')
    lsp_nmap('[w', 'diagnostic.goto_prev()')
    lsp_nmap(']w', 'diagnostic.goto_next()')
    lsp_nmap('[e', 'diagnostic.goto_prev { severity_limit = "Error" }')
    lsp_nmap(']e', 'diagnostic.goto_next { severity_limit = "Error" }')
    lsp_nmap('<leader>gwa', 'buf.add_workspace_folder()')
    lsp_nmap('<leader>gwr', 'buf.remove_workspace_folder()')

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        lsp_nmap('<leader>f', 'buf.formatting()')
    elseif client.resolved_capabilities.document_range_formatting then
        lsp_vmap('<leader>f', 'buf.range_formatting()')
    end

    lsp_setopt("formatexpr", "v:lua.require'cfg.utils'.formatexpr")
    lsp_setopt("omnifunc", "v:lua.vim.lsp.omnifunc")

    if show_diags then
        vim.api
            .nvim_command [[autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.util.show_line_diagnostics()]]
    end

    if lsp_highlights and client.resolved_capabilities.document_highlight then
        lsputil.nvim_multiline_command [[
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold,CursorHoldI  <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end

    if auto_format then
        vim.api
            .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end
end

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.util.default_config = vim.tbl_extend("force",
                                               lspconfig.util.default_config, {
    on_attach = function(client, bufnr) on_attach_wrapper(client, bufnr) end,
    capabilities = capabilities
})

local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_get_runtime_file("lua/", true)) do
        result[path:sub(1, #path - 1)] = true
    end
    return result;
end

local servers = {
    bashls = {},
    clangd = {
        cmd = {
            "clangd", "--background-index", "--clang-tidy",
            "--completion-style=bundled", "--header-insertion=iwyu",
            "--header-insertion-decorators", "--suggest-missing-includes",
            "--cross-file-rename", "--index"
            -- '--all-scopes-completion',
        },
        on_attach = function(client)
            on_attach_wrapper(client, bufnr, {auto_format = false})
            map.ncmd('gH', 'ClangdSwitchSourceHeader')
        end,
        init_options = {usePlaceholders = true, completeUnimported = true}
    },
    cmake = {},
    cssls = {},
    efm = {
        filetypes = {
            "vim", "make", "markdown", "rst", "yaml", "sh", "html", "json",
            "csv", "lua"
        }
    },
    html = {},
    -- jedi_language_server = {},
    jsonls = {cmd = {"json-languageserver", "--stdio"}},

    pyright = {
        root_dir = function(fname)
            return lsputil.root_pattern(".git", "setup.py", "setup.cfg",
                                        "pyproject.toml", "requirements.txt")(
                       fname) or lsputil.path.dirname(fname)
        end
    },
    pyls = {
        plugins = {
            jedi_completion = {enabled = false},
            jedi_definition = {enabled = false},
            jedi_symbols = {enabled = false},
            jedi_references = {enabled = false},
            mccabe = {enabled = false},
            preload = {enabled = false},
            pydocstyle = {enabled = false},
            pyflakes = {enabled = false},
            pylint = {enabled = false},
            rope_completion = {enabled = false}

        }
    },
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    enable = true,
                    globals = {
                        -- Neovim
                        "vim", "use", "it"
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
    },
    texlab = {},
    vimls = {},
    yamlls = {}
}

for server, config in pairs(servers) do
    local default_config = lspconfig[server].default_config or
                               lspconfig[server].document_config.default_config
    local cmd = config.cmd or default_config.cmd
    if vim.fn.executable(cmd[1]) == 1 then lspconfig[server].setup(config) end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false
    })
