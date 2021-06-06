local opt = vim.opt

-- poor man's version control
opt.hidden = true
opt.undofile = true
opt.swapfile = false

opt.showmode = true
opt.number = true
opt.cursorline = true
-- opt.lazyredraw = true
opt.signcolumn = "auto:2"
opt.showtabline = 2
opt.showmatch = true

opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 0
opt.softtabstop = -1
opt.tabstop = 4

opt.foldenable = false

opt.splitbelow = true
opt.splitright = true

opt.linebreak = true
opt.breakindent = true
opt.textwidth = 80
opt.colorcolumn = "+1"

opt.spelllang:append{"pt_pt", "es_es"}
opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

opt.cmdheight = 2
opt.updatetime = 300

opt.shortmess:append{a = true}

opt.gdefault = true
opt.synmaxcol = 500

opt.completeopt = {"menuone", "noselect"}
opt.scrolloff = 999
opt.sidescrolloff = 5

opt.clipboard = "unnamedplus"

opt.wildmode = {"longest", "full"}

opt.cpoptions:remove{'_'}

opt.joinspaces = true

opt.listchars = {
    tab = '> ',
    trail = '·',
    extends = '>',
    precedes = '<',
    nbsp = '+'
}
opt.list = true

opt.virtualedit = "block"
opt.spelloptions = "camel"

opt.viewoptions:remove{'options'}

vim.g.is_posix = 1
vim.g.python_host_prog = "/usr/bin/python2"
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.netrw_home = vim.fn.stdpath('data')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

opt.diffopt:append{
    ["indent-heuristic"] = true,
    hiddenoff = true,
    iblank = true,
    iwhiteall = true,
    algorithm = "histogram"
}

if vim.fn.executable('rg') then
    opt.grepprg = "rg\\ --vimgrep"
    vim.o.grepformat = "f:%l:%c:%m," .. vim.o.grepformat
end

opt.termguicolors = true
opt.pumblend = 20

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
