if !has('nvim')
    silent !mkdir -p $HOME/.vim/.undo
    silent !mkdir -p $HOME/.vim/.backup
    silent !mkdir -p $HOME/.vim/.swap
    set background=dark
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
else
    if has('termguicolors') && ($TERM=="xterm-kitty")
        set termguicolors
    endif
    let g:python_host_prog='/usr/bin/python'
    let g:python3_host_prog='/usr/bin/python3'
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

let g:is_posix = 1

" poor mans version control
set writebackup
set hidden
set undodir=~/.vim/.undo
set backupdir=~/.vim/.backup
set directory=~/.vim/.swap
set undofile
set backup
set swapfile

set background=dark
set showmode
set number relativenumber
set cursorline
set colorcolumn=80
set lazyredraw
set synmaxcol=300
if has('signcolumn')
    " Always draw the signcolumn.
    set signcolumn=yes
endif

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
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add

" Don't use Ex mode, use Q for running macros
nnoremap Q @q

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <Space> <Nop>

" Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
" but not Vi-compatible), rather than act as yy
nnoremap Y y$

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


" highlight last inserted text
nnoremap gV `[v`]

" go to first non-blank character of current line
nnoremap S ^
nnoremap E $

nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>k

nnoremap <leader>go i<CR><esc>k

nnoremap <CR> :<C-U>nohlsearch<CR><CR>

" This extends p in visual mode (note the noremap), so that if you paste from the unnamed (ie. default) register, that register content is not replaced by the visual selection you just pasted over–which is the default behavior. This enables the user to yank some text and paste it over several places in a row, without using a named register (eg. "ay, "ap etc.).
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

nnoremap <Leader>w :update<cr><cr>
nnoremap <leader>q :<C-U>quit<cr>
nnoremap <leader>z :<c-u>update <Bar>quit<cr>
nnoremap <leader>s :set spell!

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

noremap <M-l> gt
noremap <M-h> gT

" Add optional packages.
"
if empty(glob('~/.vim/autoload/plug.vim'))
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Using plug
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bronson/vim-trailing-whitespace'
Plug 'lervag/vimtex'
Plug 'editorconfig/editorconfig-vim'
Plug 'pboettch/vim-cmake-syntax'
" Plug 'luochen1990/rainbow'
Plug 'octref/rootignore'
Plug 'andrewradev/splitjoin.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-zsh'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
    Plug 'bfredl/nvim-miniyank'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'tpope/vim-sensible'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'mboughaba/i3config.vim'
Plug 'machakann/vim-highlightedyank'
" Initialize plugin system
call plug#end()

"let g:gruvbox_italic=1
colorscheme gruvbox

nnoremap <leader>t :TagbarToggle<CR>

if has('nvim')
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1
" else
endif

if !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  vmap y <Plug>(highlightedyank)
endif

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

set statusline+=%{gutentags#statusline()}
let g:airline#extensions#tabline#enabled = 1

let g:deoplete#enable_at_startup = 1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1

let g:rainbow_active = 1

nnoremap <leader>f :FZF --reverse<CR>

let g:vimtex_view_automatic='zathura'

" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})

if has("autocmd")
    augroup complete_group
        autocmd!
        autocmd CompleteDone * silent! pclose!
        autocmd InsertLeave * silent! pclose!
    augroup END

    augroup writting_autocmd
        autocmd!
        autocmd FileType markdown nnoremap <buffer> <F5> :w<CR>:!pandoc % -s -o %:r.html<CR><CR>
        autocmd FileType markdown nnoremap <buffer> <F4> :w<CR>:!pandoc % -o %:r.pdf && pkill -HUP mupdf<CR><CR><CR>
        autocmd FileType markdown let &makeprg="pandoc '%' -o '%:r'.pdf && pkill -HUP mupdf"
        autocmd FileType markdown nnoremap <buffer> <F3> :make<CR><CR>
        autocmd FileType markdown,text,tex setlocal colorcolumn=""
        autocmd FileType markdown,text,tex setlocal spell
        autocmd FileType markdown,text,tex setlocal complete+=kspell
        autocmd FileType markdown nnoremap <buffer> <F6> :Toc<CR>
    augroup END

    augroup git
        autocmd!
        autocmd FileType gitcommit setlocal textwidth=79
        autocmd FileType gitcommit setlocal formatoptions+=t
        autocmd FileType gitcommit setlocal spell
    augroup END


    augroup cpp_group
        autocmd!
        autocmd FileType c,cpp let &makeprg='make -C build '
    augroup END

"" Remember cursor position
    augroup vimrc-remember-cursor-position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END

    augroup vim_group
        autocmd!
        autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q | source $MYVIMRC
            \| endif
        autocmd BufWritePost .vimrc source $MYVIMRC
    augroup END
endif
