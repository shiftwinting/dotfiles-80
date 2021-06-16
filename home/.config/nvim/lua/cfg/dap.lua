local M = {}
local last_config

local dap = require "dap"

dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/st',
    args = {'-e'}
}

dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

local function get_env_vars()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
        table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
end

local function pick_process()
    return tonumber(vim.fn.input("Choose pid: "))
end

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb"
}

local function str_split(inputstr, sep)
    sep = sep or "%s"
    local t = {}
    for str in inputstr:gmatch("([^" .. sep .. "]+)") do table.insert(t, str) end
    return t
end

local _cmd = nil

local function get_cmd()
    if _cmd then return _cmd end
    local clipboard_cmd = vim.fn.getreg('+')
    _cmd = vim.fn.input('Command to execute: ', clipboard_cmd)
    return _cmd
end

local function get_program() return str_split(get_cmd())[1] end

local function get_args()
    local argv = str_split(get_cmd())
    local args = {}

    if #argv < 2 then return {} end

    for i = 2, #argv do args[#args + 1] = argv[i] end

    return args
end

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        cwd = '${workspaceFolder}',
        program = get_program,
        stopOnEntry = false,
        args = get_args,
        env = get_env_vars,
        runInTerminal = true
    }, {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "Attach to process",
        type = 'lldb',
        request = 'attach',
        pid = pick_process
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local get_python_path = function()
    local venv_path = os.getenv('VIRTUAL_ENV')
    if venv_path then return venv_path .. '/bin/python' end
    return "/usr/bin/python"
end

require'dap-python'.setup(get_python_path())

dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
end

dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
        host = function()
            local value = vim.fn.input('Host [127.0.0.1]: ')
            if value ~= "" then return value end
            return '127.0.0.1'
        end,
        port = function()
            local val = tonumber(vim.fn.input('Port: '))
            assert(val, "Please provide a port number")
            return val
        end
    }
}

dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    continue = {'continue', 'c'},
    next_ = {'next', 'n'},
    back = {'back', 'b'},
    reverse_continue = {'reverse-continue', 'rc'},
    into = {'into'},
    into_target = {'into_target'},
    out = {'out'},
    scopes = {'scopes'},
    threads = {'threads'},
    frames = {'frames'},
    exit = {'exit', 'quit', 'q'},
    up = {'up'},
    down = {'down'},
    goto_ = {'goto'},
    capabilities = {'capabilities', 'cap'},
    -- add your own commands
    custom_commands = {['echo'] = function(text) dap.repl.append(text) end}
})

vim.g.dap_virtual_text = 'all frames'

local map = require "mapper"
local dap_map = function(keys, func) map.nlua(keys, "require'dap'." .. func) end

dap_map('<F5>', 'continue()')
dap_map('<F10>', 'step_over()')
dap_map('<F11>', 'step_into()')
dap_map('<F12>', 'step_out()')
dap_map('<leader>b', 'toggle_breakpoint()')
dap_map('<leader>B', 'set_breakpoint(vim.fn.input("Breakpoint condition: "))')
dap_map('<leader>lp',
        'set_breakpoint(nil, nil, vim.fn.input("Log point message: "))')
dap_map('<leader>dr', 'repl.open()')
dap_map('<leader>dl', 'repl.run_last()')
dap_map('<F2>', 'list_breakpoints()')

map.nlua('<F3>', "require'dap.ui.variables'.hover()")
map.nlua('gm', "require'dap-python'.test_method()")
map.vlua('g<cr>', "require'dap-python'.debug_selection()")

require("dapui").setup({
    icons = {expanded = "-", collapsed = "+"},
    mappings = {
        -- Use a table to apply multiple mappings
        expand = "<CR>",
        open = "o",
        remove = "d",
        edit = "e"
    },
    sidebar = {
        elements = {
            -- You can change the order of elements in the sidebar
            "scopes", "breakpoints", "stacks", "watches"
        },
        width = 80,
        position = "left" -- Can be "left" or "right"
    },
    tray = {
        elements = {"repl"},
        height = 10,
        position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil -- Floats will be treated as percentage of your screen.
    }
})

return M
