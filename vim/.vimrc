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
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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

set foldenable
set foldlevelstart=1
set foldnestmax=3
set foldmethod=indent


set splitbelow
set splitright

set linebreak    "Wrap lines at convenient points
set textwidth=79

set spelllang=en
set spellfile=$HOME/dotfiles/vim/spell/en.utf-8.add

" Don't use Ex mode, use Q for running macros
nnoremap Q @q

let mapleader = "\<Space>"
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

nnoremap <CR> :nohlsearch<CR><CR>

inoremap <expr> jk pumvisible() ? "<C-e>" : "<Esc>"
inoremap <expr> kj pumvisible() ? "<C-e>" : "<Esc>"
inoremap <expr> jj pumvisible() ? "<C-e>" : "<Esc>"
inoremap <expr> <esc> pumvisible() ? "<C-e>" : "<Esc>"

" This extends p in visual mode (note the noremap), so that if you paste from the unnamed (ie. default) register, that register content is not replaced by the visual selection you just pasted over–which is the default behavior. This enables the user to yank some text and paste it over several places in a row, without using a named register (eg. "ay, "ap etc.).
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

nnoremap <silent> <Leader>w :update<cr><cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>
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

noremap <Right> :cnext<CR>
noremap <Left> :cprev<CR>

" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*~,*.tmp,*.log     " MacOSX/Linux
" set wildignore+=*.png,*jpg,*.jpeg,*.mp4,*.pb,*.bin,*.pbtxt,*.gif,*.pdf,*.o
" set wildignore+=*build/*


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
Plug 'honza/vim-snippets'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
Plug 'lervag/vimtex'
Plug 'pboettch/vim-cmake-syntax'
Plug 'luochen1990/rainbow'
Plug 'octref/rootignore'
Plug 'nacitar/a.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-clang-format'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-zsh'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kassio/neoterm'
    Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
    Plug 'bfredl/nvim-miniyank'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'tpope/vim-sensible'
endif
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'VoldikSS/vim-mma'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'mboughaba/i3config.vim'
Plug 'machakann/vim-highlightedyank'
" Initialize plugin system
call plug#end()

"let g:gruvbox_italic=1
colorscheme gruvbox

nnoremap <leader>t :TagbarToggle<CR>

 " path to directory where library can be found
 let g:clang_library_path=$HOME . '/Downloads/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04/lib/libclang.so'

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

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

let g:ale_linters = {
\   'cpp': ['cquery', 'clangd', 'clang-format', 'clang-tidy', 'uncrustify', 'cppcheck', 'flawfinder'],
\   'c': ['cquery', 'clangd', 'clang-format', 'clang-tidy', 'uncrustify', 'cppcheck', 'flawfinder'],
\}
let g:ale_cpp_cquery_executable='~/Downloads/cquery/build/release/bin/cquery'

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'camel_case': v:true,
\ 'max_list': 10,
\ })
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
call deoplete#custom#var('clangx', 'clang_binary', $HOME . '/Downloads/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04/bin/clang')


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
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#auto_formatexpr = 1

let g:vimtex_fold_enabled=1
let g:vimtex_view_automatic='zathura'
let g:vimtex_compiler_progname='nvr'

" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})

let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'cpp': ['~/Downloads/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/var/cquery/"}'],
    \ 'c': ['~/Downloads/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/var/cquery/"}'],
    \ }

    " \ 'c': [$HOME . '/Downloads/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
    " \ 'cpp': [$HOME . '/Downloads/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = $HOME . '/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader><F5> :call LanguageClient_contextMenu()<CR>

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

    augroup mathematica
        autocmd!
        autocmd BufNewFile,BufRead *.wl set filetype=mma
        autocmd BufNewFile,BufRead *.wls set filetype=mma
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

    augrou  formatting
        autocmd!
        autocmd BufNewFile,BufRead * setlocal formatoptions-=r
        autocmd BufNewFile,BufRead * setlocal formatoptions-=t
        autocmd BufNewFile,BufRead * setlocal formatoptions-=o
        autocmd BufNewFile,BufRead * hi clear SpellBad
        autocmd BufNewFile,BufRead * hi SpellBad ctermfg=Red term=Reverse guisp=Red
        autocmd QuickFixCmdPost *grep* cwindow
    augroup END

    augroup git
        autocmd!
        autocmd FileType gitcommit setlocal textwidth=79
        autocmd FileType gitcommit setlocal formatoptions+=t
        autocmd FileType gitcommit match ErrorMsg /\%1l.\%>51v/
        autocmd FileType gitcommit setlocal spell
    augroup END


    augroup cpp_group
        autocmd!
        autocmd FileType c,cpp nnoremap <buffer> <F2> :!mkdir -p build && cd build && cmake .. && cd .. && ln -s -f build/compile_commands.json <CR>
        autocmd FileType c,cpp nnoremap <buffer> <F10> :!rm -rf build<CR>
        autocmd FileType c,cpp let &makeprg='make -C build '
        autocmd FileType c,cpp nnoremap <buffer> <F5> :make 
        autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
        autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
        autocmd FileType c,cpp ClangFormatAutoEnable
        autocmd BufWritePost CMakeLists.txt :!mkdir -p build && cd build && cmake .. && cd .. && ln -s -f build/compile_commands.json <CR>
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
        autocmd BufWritePost .zshrc,.bashrc silent !source %
    augroup END
endif
