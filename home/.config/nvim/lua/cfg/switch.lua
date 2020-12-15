local map = require"mapper"

-- Don't use default mappings
vim.g.speeddating_no_mappings = 1

-- Avoid issues because of us remapping <c-a> and <c-x> below
map.n('<Plug>SpeedDatingFallbackUp', '<c-a>')
map.n('<Plug>SpeedDatingFallbackDown', '<c-x>')

-- Manually invoke speeddating in case switch didn't work
map.ncmd(']i', [[ if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif ]])
map.ncmd('[i', [[ if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif ]])
