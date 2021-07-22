vim.opt.shadafile = "NONE"

function P(v)
    print(vim.inspect(v))
    return v
end

dofile(vim.fn.stdpath("config") .. "/lua/cfg/options.lua")

vim.opt.shadafile = ""
