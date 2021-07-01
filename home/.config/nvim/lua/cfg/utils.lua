local M = {}

-- ref:
-- https://github.com/neovim/neovim/blob/e8247bc739cd0cdc32833f44973bf2d635373086/runtime/lua/vim/lsp/buf.lua#L114-L145
--@private
--- If there is more than one client that supports the given method,
--- asks the user to select one.
--
--@returns The client that the user selected or nil
local function select_client(method)
    local clients = vim.tbl_values(vim.lsp.buf_get_clients())
    clients = vim.tbl_filter(function(client)
        return client.supports_method(method)
    end, clients)
    -- better UX when choices are always in the same order (between restarts)
    table.sort(clients, function(a, b)
        return a.name < b.name
    end)

    if #clients > 1 then
        local choices = {}
        for k, v in ipairs(clients) do
            table.insert(choices, string.format("%d %s", k, v.name))
        end
        local user_choice = vim.fn.confirm(
            "Select a language server:",
            table.concat(choices, "\n"),
            0,
            "Question"
        )
        if user_choice == 0 then
            return nil
        end
        return clients[user_choice]
    elseif #clients < 1 then
        return nil
    else
        return clients[1]
    end
end

--- Performs |vim.lsp.buf.range_formatting()| synchronously.
---
--- Useful for running on save, to make sure buffer's range is formatted prior
--- to being saved. {timeout_ms} is passed on to |vim.lsp.buf_request_sync()|.
--- Example:
---
--- <pre>
--- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.range_formatting_sync()]]
--- </pre>
---
--@param options Table with valid `FormattingOptions` entries
--@param timeout_ms (number) Request timeout
function M.range_formatting_sync(options, start_pos, end_pos, timeout_ms)
    local client = select_client("textDocument/rangeFormatting")
    if client == nil then
        return
    end

    local params = vim.lsp.util.make_given_range_params(start_pos, end_pos)
    params.options = vim.lsp.util.make_formatting_params(options).options

    local result, err = client.request_sync(
        "textDocument/rangeFormatting",
        params,
        timeout_ms,
        vim.api.nvim_get_current_buf()
    )
    if result and result.result then
        vim.lsp.util.apply_text_edits(result.result)
    elseif err then
        vim.notify(
            "vim.lsp.buf.range_formatting_sync: " .. err,
            vim.log.levels.WARN
        )
    end
end

-- for use with `formatexpr`
M.formatexpr = function()
    if vim.fn.mode() == "i" or vim.fn.mode() == "R" then
        -- `formatexpr` is also called when exceding
        -- `textwidth` in insert mode
        -- fall back to internal formatting
        return 1
    end

    local start_line = vim.v.lnum
    local end_line = start_line + vim.v.count - 1
    M.range_formatting_sync({}, { start_line, 0 }, { end_line, 0 }, 500)
    return 0
end

M.formatting_hunks = function(timeout)
    local bcache =
        require("gitsigns.cache").cache[vim.api.nvim_get_current_buf()]
    if not bcache then
        return
    end
    local hunks = bcache.hunks
    if not hunks or vim.tbl_isempty(hunks) then
        return
    end
    for _, hunk in ipairs(hunks) do
        local start_line = hunk.start
        local end_line = hunk.vend

        if start_line < 0 then
            start_line = 0
        end
        if end_line > vim.api.nvim_buf_line_count(0) then
            end_line = vim.api.nvim_buf_line_count(0)
        end
        if end_line < start_line then
            end_line = start_line
        end

        if timeout then
            M.range_formatting_sync(
                {},
                { start_line, 0 },
                { end_line, 0 },
                timeout
            )
        else
            vim.lsp.buf.range_formatting({}, { start_line, 0 }, { end_line, 0 })
        end
    end
end

M.sourceLocal = function()
    local settings = vim.fn.findfile(".doit.lua", ".;")
    if settings ~= "" then
        print("sourcing local config")
        dofile(settings)
    end
end

return M
