local null_ls = require("null-ls")
local builtins = null_ls.builtins
local generator = null_ls.generator
local formatter = null_ls.formatter

null_ls.config({
    sources = {
        builtins.formatting.stylua,
        builtins.formatting.prettier,
        builtins.formatting.shfmt.with({
            args = { "-i", "4", "-ci" },
        }),
        builtins.formatting.nginx_beautifier,
        builtins.diagnostics.write_good,
        builtins.diagnostics.markdownlint,
        builtins.diagnostics.shellcheck,
        builtins.diagnostics.hadolint,
        builtins.diagnostics.vale,
        builtins.diagnostics.vint,
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

pcall(require("lspconfig")["null-ls"].setup, {})
