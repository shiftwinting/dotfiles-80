if !has('nvim')
    set t_Co=256
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
    if has('termguicolors') && ($TERM=="xterm-256" || $TERM=="xterm-kitty")
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

set writebackup
set hidden
set undodir=~/.vim/.undo
set backupdir=~/.vim/.backup
set directory=~/.vim/.swap

set background=dark
set showmode
set number relativenumber
set cursorline
set colorcolumn=80
set lazyredraw
set synmaxcol=300

set ignorecase smartcase
set showmatch

set softtabstop=4        " Sets the tab size to 4
set expandtab        " Tab key inserts spaces instead of tabs
set shiftwidth=4     " Sets spaces used for (auto)indent
set shiftround

set foldenable
set foldlevelstart=2
set foldnestmax=3
set foldmethod=syntax


set splitbelow
set splitright

set linebreak    "Wrap lines at convenient points
set textwidth=79

set spelllang=en
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add

" Don't use Ex mode, use Q for formatting
map Q gq

let mapleader=' '
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

" Add optional packages.
"
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
Plug 'tpope/vim-commentary'
"Plug 'valloric/youcompleteme'
"Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'lervag/vimtex'
Plug 'pboettch/vim-cmake-syntax'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'octref/rootignore'
Plug 'nacitar/a.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-clang-format'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'neomake/neomake'
    Plug 'kassio/neoterm'
    Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
    Plug 'arakashic/chromatica.nvim'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'tpope/vim-sensible'
    Plug 'octol/vim-cpp-enhanced-highlight'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
" Initialize plugin system
call plug#end()

"let g:gruvbox_italic=1
colorscheme gruvbox


set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*~,*.tmp,*.log     " MacOSX/Linux
set wildignore+=*.png,*jpg,*.jpeg,*.mp4,*.pb,*.bin,*.pbtxt,*.gif,*.pdf,*.o
set wildignore+=*build/*

set statusline+=%{gutentags#statusline()}
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if has('nvim')
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1
    let g:chromatica#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so.1'
    let g:chromatica#enable_at_startup=1
else
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1
endif

""let g:ycm_server_python_interpreter = '/usr/bin/python3'

"" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-j>', '<Down>', '<tab>']
"let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>', '<S-TAB>']
"let g:ycm_autoclose_preview_window_after_completion = 0
"let g:ycm_key_list_stop_completion = ['<C-y>']
"let g:ycm_confirm_extra_conf = 0

"" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<C-s>"
"let g:UltiSnipsJumpForwardTrigger = "<C-n>"
"let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
"let g:UltiSnipsListSnippets = "<C-l>"

if has('nvim')
    " Full config: when writing or reading a buffer, and on changes in insert and
    " normal mode (after 1s; no delay when writing).
    call neomake#configure#automake('nrw', 500)
    let g:neomake_open_list=2
endif

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'camel_case': v:true,
\ 'max_list': 10,
\ })
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])


" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_completed_snippet=1

" Expand the completed snippet trigger by <CR>.
imap <expr><CR>
\ (pumvisible() && neosnippet#expandable()) ?
\ "\<Plug>(neosnippet_expand)" : "\<CR>"

let g:neoterm_autoinsert=1
let g:neoterm_autoscroll=1


let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1

let g:rainbow_active = 1

nnoremap <leader>f :FZF --reverse<CR>

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

let g:vimtex_fold_enabled=1
let g:vimtex_view_automatic='zathura'
let g:vimtex_compiler_progname='nvr'

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

    augroup snippet_group
        autocmd!
        autocmd CompleteDone * call neosnippet#complete_done()
        autocmd InsertLeave * NeoSnippetClearMarkers
    augroup END

    augroup json_autocmd
        autocmd!
        autocmd BufRead,BufNewFile *.json set filetype=json
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

    augrou  formatting
        autocmd!
        autocmd BufNewFile,BufRead * setlocal formatoptions-=r
        autocmd BufNewFile,BufRead * setlocal formatoptions-=t
        autocmd BufNewFile,BufRead * setlocal formatoptions-=o
        autocmd BufNewFile,BufRead * hi clear SpellBad
        autocmd BufNewFile,BufRead * hi SpellBad ctermfg=Red term=Reverse guisp=Red
        autocmd QuickFixCmdPost *grep* cwindow
    augroup END


    augroup cpp_group
        autocmd!
        autocmd FileType cpp nnoremap <F2> :!mkdir -p build && cd build && cmake ..<CR>
        autocmd FileType cpp nnoremap <F10> :!rm -rf build && mkdir build && cd build && cmake ..<CR>
        autocmd FileType cpp let &makeprg='(mkdir -p build && cd build && make )'
        autocmd FileType cpp nnoremap <F5> :make<CR>
        autocmd FileType cpp :ClangFormatAutoEnable<CR>
        autocmd FileType cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
        autocmd FileType cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
        autocmd FileType cpp nnoremap <F8> :TagbarToggle<CR>
    augroup END

    augroup vim_group
        autocmd!
        autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
        autocmd BufWritePost .vimrc source $MYVIMRC
        autocmd BufWritePost .zshrc,.bashrc silent !source %
    augroup END
endif
