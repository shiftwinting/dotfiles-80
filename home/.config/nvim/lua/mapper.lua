local M = {}

M.map = function(mode, keys, action, buf, opts)
    opts = opts or {noremap = true, silent = true}
    buf = buf or false
    if buf then
        vim.api.nvim_buf_set_keymap(0, mode, keys, action, opts)
    else
        vim.api.nvim_set_keymap(mode, keys, action, opts)
    end
end

M.cmdi = function(mode, keys, action, buf, opts)
    opts = opts or {noremap = true, silent = false}
    M.map(mode, keys, ':' .. action, buf, opts)
end

M.cmd = function(mode, keys, action, buf, opts)
    opts = opts or {noremap = true, silent = true}
    M.cmdi(mode, keys, action .. '<cr>', buf, opts)
end

M.luai = function(mode, keys, action, buf, opts)
    M.cmdi(mode, keys, 'lua ' .. action, buf, opts)
end

M.lua = function(mode, keys, action, buf, opts)
    M.cmd(mode, keys, 'lua ' .. action, buf, opts)
end

M.plug = function(mode, keys, action, buf, opts)
    opts = opts or {silent = true, noremap = false}
    M.map(mode, keys, '<Plug>(' .. action .. ')', buf, opts)
end

M.n = function(keys, action, buf, opts) M.map('n', keys, action, buf, opts) end
M.ncmdi =
    function(keys, action, buf, opts) M.cmdi('n', keys, action, buf, opts) end
M.ncmd =
    function(keys, action, buf, opts) M.cmd('n', keys, action, buf, opts) end
M.nluai =
    function(keys, action, buf, opts) M.luai('n', keys, action, buf, opts) end
M.nlua =
    function(keys, action, buf, opts) M.lua('n', keys, action, buf, opts) end
M.nplug =
    function(keys, action, buf, opts) M.plug('n', keys, action, buf, opts) end

M.v = function(keys, action, buf, opts) M.map('v', keys, action, buf, opts) end
M.vcmdi =
    function(keys, action, buf, opts) M.cmdi('v', keys, action, buf, opts) end
M.vcmd =
    function(keys, action, buf, opts) M.cmd('v', keys, action, buf, opts) end
M.vluai =
    function(keys, action, buf, opts) M.luai('v', keys, action, buf, opts) end
M.vlua =
    function(keys, action, buf, opts) M.lua('v', keys, action, buf, opts) end
M.vplug =
    function(keys, action, buf, opts) M.plug('v', keys, action, buf, opts) end

M.i = function(keys, action, buf, opts) M.map('i', keys, action, buf, opts) end
M.iplug =
    function(keys, action, buf, opts) M.plug('i', keys, action, buf, opts) end

M.t = function(keys, action, buf, opts) M.map('i', keys, action, buf, opts) end
M.tplug =
    function(keys, action, buf, opts) M.plug('i', keys, action, buf, opts) end

return M
