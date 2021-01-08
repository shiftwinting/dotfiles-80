require "cfg.options"
require "cfg.mappings"
require "cfg.autocmds"
require "plugins"

P = function(v)
    print(vim.inspect(v))
    return v
end

local settings = vim.fn.findfile('.doit.lua', '.;')
if settings ~= '' then
    print("sourcing local config")
    dofile(settings)
end
