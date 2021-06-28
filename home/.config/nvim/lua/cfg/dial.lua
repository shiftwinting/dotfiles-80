local map = require("mapper")

map.nplug("]i", "dial-increment")
map.nplug("[i", "dial-decrement")

map.vplug("]i", "dial-increment")
map.vplug("[i", "dial-decrement")

local dial = require("dial")

dial.augends["custom#boolean"] = dial.common.enum_cyclic({
    name = "boolean",
    strlist = { "true", "false" },
})
table.insert(dial.config.searchlist.normal, "custom#boolean")
dial.augends["custom#Boolean"] = dial.common.enum_cyclic({
    name = "Boolean",
    strlist = { "True", "False" },
})
table.insert(dial.config.searchlist.normal, "custom#Boolean")
