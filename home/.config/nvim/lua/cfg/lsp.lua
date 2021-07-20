local map = require("mapper")
local lspconfig = require("lspconfig")
local lsp_spinner = require("lsp_spinner")
local luadev = require("lua-dev").setup({
    lspconfig = {
        cmd = { "lua-language-server" },
    },
})

local function format_range_operator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
        local start = vim.api.nvim_buf_get_mark(0, "[")
        local finish = vim.api.nvim_buf_get_mark(0, "]")
        vim.lsp.buf.range_formatting({}, start, finish)
        vim.go.operatorfunc = old_func
        _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = "v:lua.op_func_formatting"
    vim.api.nvim_feedkeys("g@", "n", false)
end

local function preview_location_callback(_, _, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

local function peek_callback(request)
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, request, params, preview_location_callback)
end

local on_attach_wrapper = function(client, bufnr, opts)
    local default_opts = {
        auto_format = false,
        show_diags = false,
    }
    opts = opts or default_opts
    opts = vim.tbl_extend("keep", opts, default_opts)

    local lsp_nmap = function(keys, func)
        map.nlua(keys, "vim.lsp." .. func, bufnr)
    end
    local lsp_vmap = function(keys, func)
        map.vlua(keys, "vim.lsp." .. func, bufnr)
    end

    local function lsp_setopt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    require("lsp_signature").on_attach({ fix_pos = true })
    lsp_spinner.on_attach(client, bufnr)

    if client.resolved_capabilities.code_lens then
        require("virtualtypes").on_attach()
        vim.api.nvim_command(
            [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
        )

        lsp_nmap("gl", "codelens.run()")
    end

    lsp_nmap("K", "buf.hover()")
    lsp_nmap("<c-]>", "buf.definition()")
    lsp_nmap("gD", "buf.declaration()")
    map.nlua(
        "<leader>gD",
        "require'cfg.lsp'.peek_callback('textDocument/declaration')",
        bufnr
    )
    lsp_nmap("gd", "buf.definition()")
    map.nlua(
        "<leader>gd",
        "require'cfg.lsp'.peek_callback('textDocument/definition')",
        bufnr
    )
    lsp_nmap("gt", "buf.type_definition()")
    lsp_nmap("gi", "buf.implementation()")
    lsp_nmap("gs", "buf.signature_help()")
    lsp_nmap("gh", "buf.hover()")
    lsp_nmap("gic", "buf.incoming_calls()")
    lsp_nmap("goc", "buf.outgoing_calls()")
    lsp_nmap("gr", "buf.references()")
    lsp_nmap("gR", "buf.rename()")
    lsp_nmap("ga", "buf.code_action()")
    lsp_nmap("gw", "diagnostic.show_line_diagnostics()")
    lsp_nmap("gW", "diagnostic.set_loclist()")
    lsp_nmap("[w", "diagnostic.goto_prev()")
    lsp_nmap("]w", "diagnostic.goto_next()")
    lsp_nmap("[e", 'diagnostic.goto_prev { severity_limit = "Error" }')
    lsp_nmap("]e", 'diagnostic.goto_next { severity_limit = "Error" }')

    -- Set some keybinds conditional on server capabilities
    lsp_nmap("<leader>f", "buf.formatting()")
    lsp_vmap("<leader>f", "buf.range_formatting()")
    map.nlua("<leader>hf", "require'cfg.utils'.formatting_hunks()")
    map.nlua("gf", "require'cfg.lsp'.format_range_operator()", bufnr)

    if client.supports_method("textDocument/rangeFormatting") then
        lsp_setopt("formatexpr", "v:lua.require'cfg.utils'.formatexpr()")
    end
    lsp_setopt("omnifunc", "v:lua.vim.lsp.omnifunc")

    if opts.show_diags then
        vim.api.nvim_command(
            [[autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.util.show_line_diagnostics()]]
        )
    end

    if opts.auto_format then
        if client.supports_method("textDocument/rangeFormatting") then
            vim.api.nvim_command(
                [[autocmd BufWritePre <buffer> lua require"cfg.utils".formatting_hunks(500)]]
            )
        else
            vim.api.nvim_command(
                [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
            )
        end
    end
end

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

-- turn on `window/workDoneProgress` capability
lsp_spinner.init_capabilities(capabilities)

lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach_wrapper,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }
)

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = require("lspconfig").util.validate_bufnr(bufnr)
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    vim.lsp.buf_request(
        bufnr,
        "textDocument/switchSourceHeader",
        params,
        function(err, _, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file can’t be determined")
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end
    )
end

local null_ls = require("null-ls")
local builtins = null_ls.builtins
local helpers = require("null-ls.helpers")

local severities = {
    error = vim.lsp.protocol.DiagnosticSeverity.Error,
    warning = vim.lsp.protocol.DiagnosticSeverity.Warning,
    info = vim.lsp.protocol.DiagnosticSeverity.Information,
    style = vim.lsp.protocol.DiagnosticSeverity.Hint,
}

null_ls.config({
    sources = {
        builtins.formatting.stylua,
        builtins.formatting.prettier,
        builtins.formatting.shfmt.with({
            args = { "-i", "4", "-ci" },
        }),
        builtins.diagnostics.write_good,
        builtins.diagnostics.markdownlint,
        builtins.diagnostics.shellcheck,
        builtins.diagnostics.hadolint,
        builtins.diagnostics.vale,
        builtins.code_actions.gitsigns,
        {
            name = "vint",
            method = null_ls.methods.DIAGNOSTICS,
            filetypes = { "vim" },
            generator = helpers.generator_factory({
                command = "vint",
                args = { "-", "--json", "--style-problem", "--enable-neovim" },
                on_output = function(params)
                    local diagnostics = {}
                    for _, item in ipairs(params.output or {}) do
                        table.insert(diagnostics, {
                            row = item.line_number,
                            col = item.column_number,
                            end_col = item.column_number,
                            source = "vint",
                            message = string.format(
                                "[SC%s] %s (%s)",
                                item.policy_name,
                                item.description,
                                item.reference
                            ),
                            severity = severities[item.severity],
                        })
                    end
                    return diagnostics
                end,
                to_stdin = true,
                to_stderr = true,
                ignore_errors = true,
                format = "json",
            }),
        },
        {
            name = "checkmake",
            method = null_ls.methods.DIAGNOSTICS,
            filetypes = { "make" },
            generator = helpers.generator_factory({
                command = "checkmake",
                args = {
                    "--format={{.LineNumber}}:{{.Rule}}:{{.Violation}}",
                    "$FILENAME",
                },
                on_output = function(line)
                    line = line:gsub("\r", "")
                    local items = vim.split(line, ":")
                    return {
                        row = tonumber(items[1]),
                        source = "checkmake",
                        message = items[3],
                        severity = vim.lsp.protocol.DiagnosticSeverity.Warning,
                    }
                end,
                to_stderr = true,
                ignore_errors = true,
                format = "line",
            }),
        },
        {
            name = "pandoc-markdown",
            method = null_ls.methods.FORMATTING,
            filetypes = { "markdown" },
            generator = helpers.formatter_factory({
                command = "pandoc",
                args = {
                    "-f",
                    "markdown",
                    "-t",
                    "markdown",
                    "--standalone",
                    "--columns=80",
                    "--tab-stop=2",
                },
                to_stdin = true,
            }),
        },
        {
            name = "pandoc-rst",
            method = null_ls.methods.FORMATTING,
            filetypes = { "rst" },
            generator = helpers.formatter_factory({
                command = "pandoc",
                args = {
                    "-f",
                    "rst",
                    "-t",
                    "rst",
                    "--standalone",
                    "--columns=80",
                    "--tab-stop=2",
                },
                to_stdin = true,
            }),
        },
        {
            name = "pandoc-rst",
            method = null_ls.methods.FORMATTING,
            filetypes = { "rst" },
            generator = helpers.formatter_factory({
                command = "pandoc",
                args = {
                    "-f",
                    "rst",
                    "-t",
                    "rst",
                    "--standalone",
                    "--columns=80",
                    "--tab-stop=2",
                },
                to_stdin = true,
            }),
        },
    },
})

local servers = {
    bashls = {},
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-parse=auto",
            "--completion-style=bundled",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--cross-file-rename",
            "--hidden-features",
            "--debug-origin",
            "-j=6",
            -- '--all-scopes-completion',
        },
        commands = {
            ClangdSwitchSourceHeader = {
                function()
                    switch_source_header_splitcmd(0, "edit")
                end,
                description = "Open source/header in current buffer",
            },
            ClangdSwitchSourceHeaderVSplit = {
                function()
                    switch_source_header_splitcmd(0, "vsplit")
                end,
                description = "Open source/header in a new vsplit",
            },
            ClangdSwitchSourceHeaderSplit = {
                function()
                    switch_source_header_splitcmd(0, "split")
                end,
                description = "Open source/header in a new split",
            },
        },
        on_attach = function(client, bufnr)
            on_attach_wrapper(client, bufnr, { auto_format = false })
            vim.api.nvim_command(
                [[autocmd BufWritePre *.cpp lua require"cfg.utils".formatting_hunks(500)]]
            )
            vim.api.nvim_command(
                [[autocmd BufWritePre *.h lua require"cfg.utils".formatting_hunks(500)]]
            )
            map.ncmd("gH", "ClangdSwitchSourceHeader")
            map.ncmd("gvH", "ClangdSwitchSourceHeaderVSplit")
            map.ncmd("gxH", "ClangdSwitchSourceHeaderSplit")
        end,
        init_options = { usePlaceholders = true, completeUnimported = true },
    },
    cmake = {},
    cssls = { cmd = { "css-languageserver", "--stdio" } },
    html = { cmd = { "vscode-html-languageserver", "--stdio" } },
    -- jedi_language_server = {},
    jsonls = { cmd = { "json-languageserver", "--stdio" } },
    ["null-ls"] = {},
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                },
            },
        },
    },
    pylsp = {
        configurationSources = { "flake8" },
        plugins = {
            autopep8 = { enabled = false },
            flake8 = { enabled = true },
            jedi_completion = { enabled = false },
            jedi_definition = { enabled = false },
            jedi_symbols = { enabled = false },
            jedi_references = { enabled = false },
            mccabe = { enabled = false },
            preload = { enabled = true },
            pydocstyle = { enabled = false },
            pyflakes = { enabled = false },
            pylint = { enabled = true },
            pycodestyle = { enabled = false },
            rope_completion = { enabled = false },
            yapf = { enabled = false },
        },
    },
    sumneko_lua = luadev,
    texlab = {},
    vimls = {},
    yamlls = {},
}

for server, config in pairs(servers) do
    lspconfig[server].setup(config)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = { severity_limit = "Error" },
        signs = true,
        underline = true,
        update_in_insert = false,
    }
)

vim.lsp.handlers["textDocument/codeAction"] =
    require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] =
    require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] =
    require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] =
    require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] =
    require(
        "lsputil.locations"
    ).typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] =
    require(
        "lsputil.locations"
    ).implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] =
    require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] =
    require("lsputil.symbols").workspace_handler

return {
    format_range_operator = format_range_operator,
    peek_callback = peek_callback,
}
