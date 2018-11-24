set nocompatible

set backspace=indent,eol,start

set history=10000
silent !mkdir -p $HOME/.vim/.undo
silent !mkdir -p $HOME/.vim/.backup
silent !mkdir -p $HOME/.vim/.swap
set undodir=~/.vim/.undo
set backupdir=~/.vim/.backup
set directory=~/.vim/.swap
set writebackup

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
set smarttab
filetype plugin indent on

set hidden
set autoread
set cursorline
set colorcolumn=80
set wildmenu
set lazyredraw

set scrolloff=5
set ttyfast
set noerrorbells
set belloff=all
set shell=zsh
set fileformats=unix
set visualbell
set t_Co=256

set foldenable
set foldlevelstart=2
set foldnestmax=3
set foldmethod=syntax

set timeoutlen=1000
set ttimeoutlen=10

set splitbelow
set splitright

set list listchars=tab:\ \ ,trail:·,extends:>,precedes:<,nbsp:+
set linebreak    "Wrap lines at convenient points
set textwidth=79
set spelllang=en
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add
set complete-=i
set cscopeverbose
set display+=lastline
set encoding=utf-8
set nofsync
set formatoptions+=j
set nolangremap
set laststatus=2
set sessionoptions-=options
set shortmess+=F
set tabpagemax=50
set viminfo^=!
setglobal tags-=./tags tags-=./tags; tags^=./tags;
set nrformats-=octal


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
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
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
Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'hynek/vim-python-pep8-indent'
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
Plug 'rhysd/vim-clang-format'
" Initialize plugin system
call plug#end()

let g:gruvbox_italic=1
let g:gruvbox_guisp_fallback = "fg"
colorscheme gruvbox

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

augroup writting_autocmd
    "autocmd!
    autocmd FileType markdown nnoremap <F5> :w<CR>:!pandoc % -s -o %:r.html<CR><CR>
    autocmd FileType markdown nnoremap <F4> :w<CR>:!pandoc % -o %:r.pdf && pkill -HUP mupdf<CR><CR><CR>
    autocmd FileType markdown let &makeprg="pandoc '%' -o '%:r'.pdf && pkill -HUP mupdf"
    autocmd FileType markdown nnoremap <F3> :make<CR><CR>
    autocmd FileType markdown,text,tex setlocal colorcolumn=""
    autocmd FileType markdown,text,tex setlocal spell
    autocmd FileType markdown,text,tex setlocal complete+=kspell
    autocmd FileType markdown nnoremap <F6> :Toc<CR>
augroup END

let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 0

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
"let g:cpp_no_function_highlight = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1

let g:rainbow_active = 1

let g:NERDTrimTrailingWhitespace = 1

nnoremap <leader>f :FZF --reverse<CR>

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" go to first non-blank character of current line
nnoremap S ^
nnoremap E $

augrou  formatting
    "autocmd!
    autocmd BufNewFile,BufRead * setlocal formatoptions-=r
    autocmd BufNewFile,BufRead * setlocal formatoptions-=t
    autocmd BufNewFile,BufRead * setlocal formatoptions-=o
    autocmd BufNewFile,BufRead * hi clear SpellBad
    autocmd BufNewFile,BufRead * hi SpellBad ctermfg=Red term=Reverse guisp=Red gui=undercurl ctermbg=White
augroup END


augroup cpp_group
    "autocmd!
    autocmd FileType cpp nnoremap <F2> :!mkdir -p build && cd build && cmake ..<CR>
    autocmd FileType cpp nnoremap <F10> :!rm -rf build && mkdir build && cd build && cmake ..<CR>
    autocmd FileType cpp let &makeprg='(mkdir -p build && cd build && make adas)'
    autocmd FileType cpp nnoremap <F5> :make<CR>
    autocmd FileType cpp :ClangFormatAutoEnable<CR>
    autocmd FileType cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
    autocmd FileType cpp nnoremap <F8> :TagbarToggle<CR>
augroup END

autocmd BufWritePost .vimrc source $MYVIMRC
