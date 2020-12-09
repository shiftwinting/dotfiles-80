local map = require "mapper"

map.n('<Space>', '<Nop>')

-- Don't use Ex mode, use Q for running macros
map.n('Q', '@q')

-- make an accidental ; press also enter command mode
-- temporarily disabled to to vim-sneak plugin
map.n(';', ':')

-- Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
-- but not Vi-compatible), rather than act as yy
map.n('Y', 'y$')

-- highlight last inserted text
map.n('gV', '`[v`]')

map.n('<down>', '<c-e>')
map.n('<up>', '<c-y>')


map.n('=', '<c-a>')
map.v('=', '<c-a>')
map.n('-', '<c-x>')
map.v('-', '<c-x>')

-- go to first non-blank character of current line
map.n('<c-a>', '^')
map.v('<c-a>', '^')
map.n('<c-e>', '$')
map.v('<c-e>', '$')

-- This extends p in visual mode (note the noremap), so that if you paste from
-- the unnamed (ie. default) register, that register content is not replaced by
-- the visual selection you just pasted over–which is the default behavior.
-- This enables the user to yank some text and paste it over several places in
-- a row, without using a named register
-- map.v('p', "p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>")
map.v('p', 'p:let @+=@0<CR>:let @"=@0<CR>')

map.v('<leader>p', '"_dP')
map.n('<leader>d', '"_d')
map.n('<leader>D', '"_D')
map.map('', '<leader>c', '"_c')
map.map('', '<leader>C', '"_C')

-- Find and Replace binds
map.ncmdi('<leader>s', '%s/')
map.vcmdi('<leader>s', 's/')
map.ncmdi('<leader>gs', '%s/<c-r>"/')
map.vcmdi('<leader>gs', 's/<c-r>"/')
map.ncmdi('<Leader>S', '%s/<C-r><C-w>/')

map.ncmd('<leader>x', 'wall')
map.ncmd('<leader>z', 'wqall')
map.ncmd('<leader>q', 'quitall')
map.ncmd('<localleader>x', 'update')

map.t('<Esc>', "<c-\\><c-n>", {silent = true, noremap = true, expr = true})

map.i('jj', '<esc>')
map.i('kk', '<esc>')
map.i('jk', '<esc>')
map.i('kj', '<esc>')
