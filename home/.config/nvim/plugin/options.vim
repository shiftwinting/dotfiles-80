if exists('g:loaded_options')
    finish
endif
let g:loaded_options = 1

if !has('nvim')
    set backupdir=$XDG_DATA_HOME/nvim/backup | call mkdir(&backupdir, 'p', 0700)
    set directory=$XDG_DATA_HOME/nvim/swap | call mkdir(&directory, 'p', 0700)
	set viewdir=$XDG_DATA_HOME/nvim/view   | call mkdir(&viewdir, 'p', 0700)
    set undodir=$XDG_DATA_HOME/nvim/undo | call mkdir(&undodir, 'p', 0700)
    set viminfo+='1000,n$XDG_DATA_HOME/nvim/viminfo
    set belloff=all
    set cscopeverbose
    set nofsync
    set hlsearch         " Turns on highlighting for matched search patterns
    if exists('+langnoremap')
        set langnoremap
    endif
    set shortmess+=F
    set shortmess-=S
    set showcmd		" display incomplete commands
    set sidescroll=1
    set nostartofline
    set ttyfast
    set ttymouse=xterm2
    if &term =~# '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://sunaku.github.io/vim-256color-bce.html
	set t_ut=
    endif
else
    let g:python_host_prog='/usr/bin/python2'
    let g:python3_host_prog='/usr/bin/python3'
    set inccommand=nosplit
endif


" poor mans version control
set hidden
if has('persistent_undo')
    set undofile
endif
set noswapfile

if !has('nvim')
    set background=dark
endif

set showmode
set number
set cursorline
set colorcolumn=81
set lazyredraw
if has('signcolumn')
    " Always draw the signcolumn.
    set signcolumn=yes
endif
set showtabline=2

set ignorecase
set smartcase
set showmatch

set expandtab        " Tab key inserts spaces instead of tabs
set shiftround
set shiftwidth=0
set softtabstop=-1
set tabstop=4

set nofoldenable

set splitbelow
set splitright

set linebreak    "Wrap lines at convenient points
set textwidth=80

set spelllang=en,pt_pt,es_es
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

set shortmess-=f
set shortmess-=i
set shortmess-=l
set shortmess-=m
set shortmess-=n
set shortmess-=r
set shortmess-=w
set shortmess-=x
set shortmess+=a

" Set commentstring globally for all undetected filetypes
set commentstring=#\ %s

set gdefault

if &synmaxcol == 3000
  " Lowering this improves performance in files with long lines.
  set synmaxcol=500
endif


set completeopt=menuone,noinsert,noselect

set scrolloff=999
set sidescrolloff=999

if has('clipboard')
    set clipboard+=unnamedplus
endif

set wildmode=longest,full

set cpoptions-=_

set nojoinspaces

set listchars+=trail:·
set list

set title
set signcolumn=auto:2

if has('nvim-0.5')
    set spelloptions=camel
endif

let g:is_posix=1

let g:netrw_home=expand("$XDG_DATA_HOME/nvim")

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('nvim-0.3.2') || has('patch-8.1.0360')
    set diffopt=filler,internal,indent-heuristic,hiddenoff,iblank,iwhiteall,algorithm:histogram
endif

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif
