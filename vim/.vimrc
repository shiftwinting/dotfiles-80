" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set noswapfile
set nowb
set undofile		" keep an undo file (undo changes after closing)
set history=100		" keep 100 lines of command line history


" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif


set showcmd		" display incomplete commands
set showmode
set incsearch		" do incremental searching
set ignorecase smartcase
set number relativenumber
set background=dark
syntax on            " Turn on syntax highlighting
set hlsearch         " Turns on highlighting for matched search patterns
set showmatch

set softtabstop=4        " Sets the tab size to 4
set expandtab        " Tab key inserts spaces instead of tabs
set shiftwidth=4     " Sets spaces used for (auto)indent
set autoindent       " Carries over previous indent to the next line
set shiftround
filetype plugin indent on

set hidden
set autoread
set cursorline
set colorcolumn=80
set wildmenu
set ignorecase
set smartcase
set lazyredraw

set scrolloff=5
set sidescrolloff=5
set ttyfast
set noerrorbells
set shell=zsh
"set fileformats=unix
set visualbell
set t_Co=256

set foldenable
set foldlevelstart=2
set foldnestmax=3
set foldmethod=syntax

set list listchars=tab:\ \ ,trail:·
set linebreak    "Wrap lines at convenient points
set textwidth=79

let mapleader=' '

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

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
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
"Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'valloric/youcompleteme'
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
"Plug 'hynek/vim-python-pep8-indent'
"Plug 'chrisbra/csv.vim'
"Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pboettch/vim-cmake-syntax'
Plug 'luochen1990/rainbow'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'octref/rootignore'
Plug 'nacitar/a.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'michaeljsmith/vim-indent-object'
" Initialize plugin system
call plug#end()


colorscheme gruvbox

"nnoremap <C-n> :NERDTreeToggle<CR>

autocmd QuickFixCmdPost *grep* cwindow

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{FugitiveStatusline()}

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*~,*.tmp,*.log     " MacOSX/Linux
set wildignore+=*.png,*jpg,*.jpeg,*.mp4,*.pb,*.bin,*.pbtxt,*.gif,*.pdf,*.o

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_theme='powerlineish'

"let g:ycm_server_python_interpreter = '/usr/bin/python3'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>', '<tab>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>', '<S-TAB>']
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_key_list_stop_completion = ['<C-y>']
let g:ycm_confirm_extra_conf = 0

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-s>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
let g:UltiSnipsListSnippets = "<C-l>"

au! BufRead,BufNewFile *.json set filetype=json

augroup json_autocmd
    autocmd!
    autocmd FileType json setlocal formatoptions=tcq2l
    autocmd FileType json setlocal textwidth=78 shiftwidth=2
    autocmd FileType json setlocal softtabstop=2 tabstop=8
    autocmd FileType json setlocal expandtab
    autocmd FileType json setlocal foldmethod=syntax
augroup END

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1

let g:rainbow_active = 1

let g:NERDTrimTrailingWhitespace = 1

nnoremap <leader>f :FZF --reverse<CR>

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" go to first non-blank character of current line
nnoremap 0 ^

augrou  formatting
    autocmd!
    autocmd BufNewFile,BufRead * setlocal formatoptions-=ro
    autocmd BufNewFile,BufRead * setlocal formatoptions+=t
    autocmd BufNewFile,BufRead * setlocal textwidth=79
augroup END

set timeoutlen=1000
set ttimeoutlen=10

set splitbelow
set splitright

let &makeprg='(mkdir -p build && cd build && make adas)'

nnoremap <F8> :TagbarToggle<CR>

