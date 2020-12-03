local map = require "mapper"

map.ncmd("m<cr>", "execute 'Make g:targets'")
map.ncmd("m!", "execute 'Make! g:targets'")
map.ncmdi("m<space>", "Make<space>")
