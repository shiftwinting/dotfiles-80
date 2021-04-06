require('Navigator').setup({
    disable_on_zoom = true
})

local map = require"mapper"

map.nlua("<c-h>", "require('Navigator').left()")
map.nlua("<c-k>", "require('Navigator').up()")
map.nlua("<c-l>", "require('Navigator').right()")
map.nlua("<c-j>", "require('Navigator').down()")
