require "cfg.options"
require "cfg.mappings"
require "cfg.autocmds"
require "plugins"

P = function(v)
    print(vim.inspect(v))
    return v
end

SourceLocal = function()
    local localcfg = "doit.lua"
    local cwd = vim.fn.getcwd()
    local path = cwd .. '/' .. localcfg
    if vim.fn.filereadable(path) == 1 then
        print("sourcing local config")
        vim.cmd("luafile " .. localcfg)
    end
end
