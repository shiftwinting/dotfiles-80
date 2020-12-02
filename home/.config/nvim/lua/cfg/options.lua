require "globals"
local opt = vim.opt

-- poor man's version control
opt.hidden = true
opt.undofile = true
opt.swapfile = false

opt.showmode = true
opt.number = true
opt.cursorline = true
opt.lazyredraw = true
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

opt.spelllang = {"en", "pt_pt", "es_es"}
opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

opt.cmdheight = 2
opt.updatetime = 300

opt.shortmess = opt.shortmess - 'f' - 'i' - 'l' - 'm' - 'n' - 'r' - 'w' - 'x'

-- opt.shortmess = opt.shortmess + 'a'
opt.gdefault = true
opt.synmaxcol = 500

opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.scrolloff = 999

opt.clipboard = "unnamedplus"

opt.wildmode = {"longest", "full"}

-- opt.cpoptions = opt.cpoptions - '_'

opt.joinspaces = true

-- opt.listchars = append(opt.listchars, "trail:·", ',')
opt.list = true

opt.virtualedit = "block"
opt.spelloptions = "camel"

vim.g.is_posix = 1
vim.g.netrw_home = vim.fn.stdpath('data')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

opt.diffopt =
    "filler,internal,indent-heuristic,hiddenoff,iblank,iwhiteall,algorithm:histogram"

if vim.fn.executable('rg') then
    opt.grepprg = "rg\\ --vimgrep"
    vim.o.grepformat = "f:%l:%c:%m," .. vim.o.grepformat
end

opt.termguicolors = true
opt.pumblend = 20

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
