if exists('g:loaded_options')
    finish
endif
let g:loaded_options = 1

if !has('nvim')
    set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
    set belloff=all
    set cscopeverbose
    set directory=$XDG_CACHE_HOME/vim/swap | call mkdir(&directory, 'p', 0700)
	set viewdir=$XDG_CACHE_HOME/vim/view   | call mkdir(&viewdir, 'p', 0700)
    set nofsync
    set hlsearch         " Turns on highlighting for matched search patterns
    if exists('+langnoremap')
        set langnoremap
    endif
    set shortmess+=F
    set shortmess-=S
    set showcmd		" display incomplete commands
    set sidescroll=1
    set ttyfast
    set ttymouse=xterm2
    set undodir=$XDG_DATA_HOME/vim/undo | call mkdir(&undodir, 'p', 0700)
    if &term =~# '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://sunaku.github.io/vim-256color-bce.html
	set t_ut=
	set viminfo+=$XDG_CACHE_HOME/vim/viminfo
	set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
    endif
else
    let g:python_host_prog='/usr/bin/python2'
    let g:python3_host_prog='/usr/bin/python3'
    set wildoptions=tagfile
    set inccommand=nosplit
endif

if has('termguicolors') && &term =~# '256color'
    if !has('nvim')
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set background=dark
    endif
    set termguicolors
    if has('nvim-0.4')
        lua require'colorizer'.setup()
    endif
endif

" poor mans version control
set writebackup
set hidden
if has('persistent_undo')
    set undofile
endif
set swapfile

if !has('nvim')
    set background=dark
endif
if !g:use_plugins
    colorscheme desert
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
set spellfile=$HOME/.vim/spell/en.utf-8.add

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Set commentstring globally for all undetected filetypes
set commentstring=#\ %s

set gdefault

set path+=**

if &synmaxcol == 3000
  " Lowering this improves performance in files with long lines.
  set synmaxcol=500
endif

set nostartofline

set completeopt=menuone,noinsert,noselect

set scrolloff=999
set sidescrolloff=999

let g:is_posix=1

" highlight merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('nvim-0.3.2') || has('patch-8.1.0360')
    set diffopt=filler,internal,indent-heuristic,hiddenoff,iblank,iwhiteall,algorithm:histogram
endif