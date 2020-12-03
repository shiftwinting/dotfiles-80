local on_attach_wrapper = function(client, user_opts)
    local opts = user_opts or
                     {
            auto_format = true,
            show_diags = false,
            lsp_highlights = false
        }
    local auto_format = opts.auto_format or false
    local show_diags = opts.show_diags or false
    local lsp_highlights = opts.lsp_highlights or false
    require"completion".on_attach(client)

    local map = require "mapper"
    local lsp_nmap = function(keys, func)
        map.nlua(keys, "vim.lsp." .. func, true)
    end
    local lsp_vmap = function(keys, func)
        map.vlua(keys, "vim.lsp." .. func, true)
    end

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
    lsp_nmap('<leader>f', 'buf.formatting()')
    lsp_nmap('ga', 'buf.code_action()')
    lsp_nmap('gw', 'diagnostic.show_line_diagnostics()')
    lsp_nmap('gW', 'diagnostic.set_loclist()')
    lsp_nmap('[w', 'diagnostic.goto_prev()')
    lsp_nmap(']w', 'diagnostic.goto_next()')
    lsp_nmap('[e', 'diagnostic.goto_prev { severity_limit = "Error" }')
    lsp_nmap(']e', 'diagnostic.goto_next { severity_limit = "Error" }')
    lsp_vmap('<leader>f', 'buf.range_formatting()')

    vim.bo.formatexpr = "v:lua.require'cfg.utils'.formatexpr"
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    if show_diags then
        vim.api
            .nvim_command [[autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.util.show_line_diagnostics()]]
    end

    if lsp_highlights then
        vim.api
            .nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api
            .nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api
            .nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end

    if auto_format then
        vim.api
            .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end
end

local lspconfig = require "lspconfig"

lspconfig.util.default_config = vim.tbl_extend("force",
                                               lspconfig.util.default_config, {
    on_attach = function(client) on_attach_wrapper(client, nil) end
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
    on_attach = function(client)
        on_attach_wrapper(client, {auto_format = false})
        mapper('gH', ':ClangdSwitchSourceHeader<CR>')
    end,
    init_options = {usePlaceholders = true, completeUnimported = true}
}
lspconfig.jsonls.setup {cmd = {"json-languageserver"}}
lspconfig.texlab.setup {}
lspconfig.vimls.setup {}
lspconfig.html.setup {}
lspconfig.cmake.setup {}
lspconfig.cssls.setup {}
lspconfig.yamlls.setup {}

local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_get_runtime_file("lua/", true)) do
        result[path:sub(1, #path - 1)] = true
    end
    return result;
end

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {version = "LuaJIT"},
            completion = {
                -- You should use real snippets
                keywordSnippet = "Disable"
            },
            diagnostics = {
                enable = true,
                globals = {
                    -- Neovim
                    "vim" -- Busted
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

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false
    })
