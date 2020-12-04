vim.g.dispatch_no_maps = 1
local map = require "mapper"

vim.g.targets = ''

map.ncmd("m<cr>", "let @s=g:targets<CR>:Make<Space><c-r>s")
map.ncmd("m!", "let @s=g:targets<CR>:Make!<Space><c-r>s")
map.ncmdi('m<space>', "let @s=g:targets<CR>:Make<Space><c-r>s<Space>")

map.ncmd("'<cr>", "let @s=g:start<CR>:Start<Space><c-r>s")
map.ncmd("'!", "let @s=g:start<CR>:Start!<Space><c-r>s")
map.ncmdi("'<space>", "let @s=g:start<CR>:Start<Space><c-r>s<Space>")
