
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

set number relativenumber
let mapleader=' '
set background=dark
syntax on            " Turn on syntax highlighting
                     " (makes code and config files more readable)
set background=dark  " If using a dark background, instead of the
                     " usual white background in Terminal
                     " (makes darker colors brighter)
set incsearch        " Used for incremental searching
                     " (useful when searching large text files)
set hlsearch         " Turns on highlighting for matched search patterns
                     " (use :nohlsearch inside vim to turn off highlights
                     " after a search)
set tabstop=4        " Sets the tab size to 4
                     " (tabs are usually 8 spaces)
set expandtab        " Tab key inserts spaces instead of tabs
set shiftwidth=4     " Sets spaces used for (auto)indent
set shiftround       " Indent to nearest tabstop
set autoindent       " Carries over previous indent to the next line
set hidden
set autoread
set cursorline
filetype indent on
set wildmenu
set showmatch
set ignorecase
set smartcase
set more
set lazyredraw
set showmode
set nocompatible
set smartindent
set smarttab
set scrolloff=5
set sidescrolloff=5
set ttyfast
set noerrorbells
set shell=zsh
set fileformats=unix
filetype on
set visualbell
set t_vb=
set t_Co=256

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set list listchars=tab:\ \ ,trail:·
set linebreak    "Wrap lines at convenient points

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Using plug
Plug 'flazz/vim-colorschemes'
Plug 'dylanaraps/wal.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'chrisbra/csv.vim'
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pboettch/vim-cmake-syntax'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-eunuch'
Plug 'yuttie/comfortable-motion.vim'
" Initialize plugin system
call plug#end()

"colorscheme wal
colorscheme molokai

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

autocmd QuickFixCmdPost *grep* cwindow

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{FugitiveStatusline()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

let g:ycm_server_python_interpreter = '/usr/bin/python'

let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

au! BufRead,BufNewFile *.json set filetype=json

augroup json_autocmd
     autocmd!
     autocmd FileType json set autoindent
     autocmd FileType json set formatoptions=tcq2l
     autocmd FileType json set textwidth=78 shiftwidth=2
     autocmd FileType json set softtabstop=2 tabstop=8
     autocmd FileType json set expandtab
     autocmd FileType json set foldmethod=syntax
 augroup END

let g:pymode_python = 'python3'

let g:csv_highlight_column = 'y'

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1
let g:rainbow_active = 1
