local mapper = require"cfg.utils".mapper
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
