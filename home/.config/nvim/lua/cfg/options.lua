local opt = vim.o

local sub = function(option, field)
    return vim.split(option:gsub(field, "", 1), " ")[1]
end

local append = function(option, field, sep, prepend)
    sep = sep or ''
    prepend = prepend or false
    if option:find(field) == nil then
        if option == '' then
            return field
        else
            if prepend then
                return field .. sep .. option
            else
                return option .. sep .. field
            end
        end
    else
        return option
    end
end

local prepend = function(option, field, sep)
    return append(option, field, sep, true)
end

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

opt.spelllang = "en,pt_pt,es_es"
opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

opt.cmdheight = 2
opt.updatetime = 300

opt.shortmess = sub(opt.shortmess, 'f')
opt.shortmess = sub(opt.shortmess, 'i')
opt.shortmess = sub(opt.shortmess, 'l')
opt.shortmess = sub(opt.shortmess, 'm')
opt.shortmess = sub(opt.shortmess, 'n')
opt.shortmess = sub(opt.shortmess, 'r')
opt.shortmess = sub(opt.shortmess, 'w')
opt.shortmess = sub(opt.shortmess, 'x')
opt.shortmess = append(opt.shortmess, 'a')

opt.gdefault = true
opt.synmaxcol = 500

opt.completeopt = "menuone,noinsert,noselect"
opt.scrolloff = 999

opt.clipboard = "unnamedplus"

opt.wildmode = "longest,full"

opt.cpoptions = sub(opt.cpoptions, '_')

opt.joinspaces = true

opt.listchars = append(opt.listchars, "trail:·", ',')
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
    opt.grepprg = "rg --vimgrep"
    opt.grepformat = "%f:%l:%c:%m," .. opt.grepformat
end

opt.termguicolors = true
opt.pumblend = 20

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
