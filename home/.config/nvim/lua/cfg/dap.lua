local M = {}
local last_gdb_config

local dap = require "dap"

M.start_c_debugger = function(args)
    if args and #args > 0 then
        last_config = {
            type = "lldb",
            name = args[1],
            request = "launch",
            program = table.remove(args, 1),
            args = args,
            cwd = vim.fn.getcwd(),
            env = function()
                local variables = {}
                for k, v in pairs(vim.fn.environ()) do
                    table.insert(variables, string.format("%s=%s", k, v))
                end
                return variables
            end
        }
    end

    if not last_config then
        print('No binary to debug set! Use ":DebugC <binary> <args>"')
        return
    end

    dap.run(last_config)
    dap.repl.open()
end

dap.adapters.lldb = {
    type = "executable",
    attach = {pidProperty = "pid", pidSelect = "ask"},
    command = "lldb-vscode",
    env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"},
    name = "lldb"
}

local find_python = function()
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
        pythonPath = find_python()
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
    command! -complete=file -nargs=* DebugC lua require "cfg.dap".start_c_debugger({<f-args>})
]]

vim.g.dap_virtual_text = 'all frames'

local dap_map = function(keys, func)
    vim.api.nvim_set_keymap('n', keys, ":lua require'dap'." .. func .. "()<cr>",
                            {noremap = true, silent = true})
end

dap_map('<F5>', 'continue')
dap_map('<F6>', 'step_over')
dap_map('<F7>', 'step_into')
dap_map('<F8>', 'step_out')
dap_map('<F9>', 'toggle_breakpoint')
dap_map('<F1>', 'repl.open')
dap_map('<F10>', 'repl.run_last')
dap_map('<F2>', 'list_breakpoints')

vim.api.nvim_set_keymap('n', 'g<cr>', ":execute 'DebugC' g:dbg_cmd<cr>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'g<space>',
                        ":let @s=g:dbg_cmd<CR>:DebugC<Space><c-r>s<Space>",
                        {noremap = true, silent = true})

return M
