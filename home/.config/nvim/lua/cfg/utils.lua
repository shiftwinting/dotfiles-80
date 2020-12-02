local M = {}
-- for use with `formatexpr` if called without parms
-- @param start_line 1-indexed line
-- @param end_line 1-indexed line
-- @param timeout_ms optional
M.formatexpr = function(start_line, end_line, timeout_ms)
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

M.mapper = function(keys, action)
    vim.api.nvim_buf_set_keymap(0, 'n', keys, action,
                                {noremap = true, silent = true})
end


return M
