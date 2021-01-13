local map = require "mapper"

map.nplug(']i', 'dial-increment')
map.nplug('[i', 'dial-decrement')

map.vplug(']i', 'dial-increment')
map.vplug('[i', 'dial-decrement')

local dial = require("dial")

local my_augends = {
    dial.augends.common.enum_cyclic {
        name = "boolean",
        strlist = {"true", "false"}
    },
    dial.augends.common.enum_cyclic {
        name = "Boolean",
        strlist = {"True", "False"}
    },
}

vim.list_extend(dial.searchlist.normal, my_augends)
