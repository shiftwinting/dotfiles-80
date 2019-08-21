if exists('g:loaded_options')
    finish
endif
let g:loaded_options = 1

if !has('nvim')
    silent !mkdir -p $HOME/.vim/.undo
    silent !mkdir -p $HOME/.vim/.backup
    silent !mkdir -p $HOME/.vim/.swap
    set belloff=all
    set cscopeverbose
    set nofsync
    set hlsearch         " Turns on highlighting for matched search patterns
    if exists('+langnoremap')
        set langnoremap
    endif
    set shortmess+=F
    set showcmd		" display incomplete commands
    set ttyfast
    set ttymouse=xterm2
    if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://sunaku.github.io/vim-256color-bce.html
	set t_ut=
    endif
endif

if has('termguicolors')
    if !has('nvim')
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    " set t_Co=256
    set termguicolors
endif

" poor mans version control
set writebackup
set hidden
set undodir=~/.vim/.undo
set backupdir=~/.vim/.backup
set directory=~/.vim/.swap
if has('persistent_undo')
    set undofile
endif
set backup
set swapfile

set background=dark
if !g:use_plugins
    colorscheme desert
endif
set showmode
set number relativenumber
set cursorline
if g:use_plugins
    set colorcolumn=80
endif
set lazyredraw
if has('signcolumn')
    " Always draw the signcolumn.
    set signcolumn=yes
endif
set showtabline=2

set ignorecase smartcase
set showmatch

set softtabstop=4        " Sets the tab size to 4
set expandtab        " Tab key inserts spaces instead of tabs
set shiftwidth=4     " Sets spaces used for (auto)indent
set shiftround

set nofoldenable

set splitbelow
set splitright

set linebreak    "Wrap lines at convenient points
set textwidth=79

set spelllang=en
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

let g:is_posix=1

" highlight merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif
