local lsp_status = function()
    local sl = "[]"
    if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        sl = string.format("[%s] ", require("lsp_spinner").status())
        sl = sl
            .. string.format(
                "E: %s W: %s",
                vim.lsp.diagnostic.get_count(0, [[Error]]),
                vim.lsp.diagnostic.get_count(0, [[Warning]])
            )
    end
    return sl
end

local function statusline_generator()
    local builtin = require("el.builtin")
    local sections = require("el.sections")
    return {
        builtin.filetype,
        "%f",
        builtin.help,
        builtin.modified,
        builtin.readonly,
        builtin.preview,
        builtin.quickfix,
        builtin.loclist,
        string.format("[%s, %s]", builtin.column, builtin.number_of_lines),
        sections.split,
        lsp_status,
    }
end

require("el").setup({ generator = statusline_generator })
