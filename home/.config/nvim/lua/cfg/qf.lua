local map = require("mapper")
vim.g.qf_shorten_path = 0

map.nplug("<localleader>q", "qf_qf_toggle_stay")
map.nplug("<localleader>l", "qf_loc_toggle_stay")
