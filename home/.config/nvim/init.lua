require "cfg.options"
require "cfg.mappings"
require "cfg.autocmds"
require "plugins"

P = function(v)
    print(vim.inspect(v))
    return v
end
