local map = require"mapper"

-- Don't use default mappings
vim.g.speeddating_no_mappings = 1

-- Avoid issues because of us remapping <c-a> and <c-x> below
map.n('<Plug>SpeedDatingFallbackUp', '<c-a>')
map.n('<Plug>SpeedDatingFallbackDown', '<c-x>')

-- Manually invoke speeddating in case switch didn't work
map.ncmd(']i', [[ let mycount = v:count1 <bar> if !switch#Switch() <bar> call speeddating#increment(mycount) <bar> unlet mycount <bar> endif ]])
map.ncmd('[i', [[ let mycount = v:count1 <bar> if !switch#Switch({'reverse': v:true}) <bar> call speeddating#increment(-mycount) <bar> unlet mycount <bar> endif ]])
