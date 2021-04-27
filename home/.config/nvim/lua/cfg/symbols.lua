local symbols = require"symbols-outline"
local map = require"mapper"

symbols.setup()

map.nlua('<leader>t', "require'symbols-outline'.toggle_outline()")
