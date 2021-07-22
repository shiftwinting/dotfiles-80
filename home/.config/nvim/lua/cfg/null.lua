local null_ls = require("null-ls")
local builtins = null_ls.builtins
local generator = null_ls.generator
local formatter = null_ls.formatter

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
            generator = generator({
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
            generator = generator({
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
            generator = formatter({
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
            generator = formatter({
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
            generator = formatter({
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

pcall(require("lspconfig")["null-ls"].setup,{})
