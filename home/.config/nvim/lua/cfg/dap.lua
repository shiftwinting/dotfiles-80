local M = {}
local last_config

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

local get_python_path = function()
    local venv_path = os.getenv('VIRTUAL_ENV')
    if venv_path then
        return venv_path .. '/bin/python'
    end
    return "/usr/bin/python"
end

require'dap-python'.setup(get_python_path())

dap.configurations.lua = { 
  { 
    type = 'nlua', 
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end

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

local map = require "mapper"
local dap_map = function(keys, func) map.nlua(keys, "require'dap'." .. func) end

dap_map('<F5>', 'continue()')
dap_map('<F6>', 'step_over()')
dap_map('<F7>', 'step_into()')
dap_map('<F8>', 'step_out()')
dap_map('<F9>', 'toggle_breakpoint()')
dap_map('<F1>', 'repl.open()')
dap_map('<F10>', 'repl.run_last()')
dap_map('<F2>', 'list_breakpoints()')
dap_map('<F3>', 'ui.variables.hover()')

vim.g.dbg_cmd = ''
map.ncmd('g<cr>', "let @s=g:dbg_cmd<CR>:DebugC<Space><c-r>s")
map.ncmdi('g<space>', "let @s=g:dbg_cmd<CR>:DebugC<Space><c-r>s<Space>")
map.nlua('gm', "require'dap-python'.test_method()")
map.vlua('g<cr>', "require'dap-python'.debug_selection()")

return M
