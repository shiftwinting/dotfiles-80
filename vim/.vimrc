let s:use_plugins = 1
let s:use_crystalline = 1
let s:is_ide = 1

if !s:use_plugins
    let s:is_ide = 0
    source $HOME/.my-vim-plugs/sensible.vim
endif

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
else
    let g:python_host_prog='/usr/bin/python2'
    let g:python3_host_prog='/usr/bin/python3'
endif

if has('termguicolors')
    if !has('nvim')
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set t_Co=256
    set termguicolors
endif
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

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
if !s:use_plugins
    colorscheme desert
endif
set showmode
set number relativenumber
set cursorline
if s:use_plugins
    set colorcolumn=80
endif
set lazyredraw
set synmaxcol=300
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
set spellfile=$HOME/.spell/en.utf-8.add

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Set commentstring globally for all undetected filetypes
set commentstring=#\ %s

let g:is_posix=1

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

nnoremap <silent><CR> :<C-U>nohlsearch<CR><CR>

" This extends p in visual mode (note the noremap), so that if you paste from
" the unnamed (ie. default) register, that register content is not replaced by
" the visual selection you just pasted over–which is the default behavior.
" This enables the user to yank some text and paste it over several places in
" a row, without using a named register (eg. "ay, "ap etc.).
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

nnoremap <leader>s :set spell!

function! Write_emoji()
    return system('emoji')
endfunction

nnoremap <leader>e "=Write_emoji()<CR>P

"" Copy/Paste/Cut
" if has('unnamedplus')
"   set clipboard=unnamed,unnamedplus
" endif

nnoremap YY "+y<CR>
nnoremap <leader>p "+gP<CR>
nnoremap XX "+x<CR>

if has('nvim')
    nnoremap <M-l> gt
    nnoremap <M-h> gT
endif

" highlight merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

if s:use_plugins
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
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'machakann/vim-sandwich'
    Plug 'gruvbox-community/gruvbox'
    if s:use_crystalline
        Plug 'rbong/vim-crystalline'
    endif
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'luochen1990/rainbow'
    Plug 'michaeljsmith/vim-indent-object'
    if has('nvim')
        Plug 'bfredl/nvim-miniyank'
        Plug 'lambdalisue/suda.vim'
    endif
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'mboughaba/i3config.vim'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'dag/vim-fish'
    if s:is_ide
        Plug 'majutsushi/tagbar'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'w0rp/ale'
        Plug 'honza/vim-snippets'
        Plug 'vim-pandoc/vim-pandoc'
        Plug 'lervag/vimtex'
        Plug 'sbdchd/neoformat'
        Plug 'Shougo/neco-vim'
        Plug 'neoclide/coc-neco'
        Plug 'Shougo/neoinclude.vim'
        Plug 'jsfaint/coc-neoinclude'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
        Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile'}
        Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
        " Plug 'Maxattax97/coc-ccls', {'do': 'yarn install --frozen-lockfile'}
    endif
    " Initialize plugin system
    call plug#end()


    let g:gruvbox_italic=1
    colorscheme gruvbox
    nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
    nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
    nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

    nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
    nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
    nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

    if s:use_crystalline
        function! StatusLine(current, width)
        let l:s = ''

        if a:current
            let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
        else
            let l:s .= '%#CrystallineInactive#'
        endif
        let l:s .= ' %f%h%w%m%r '
        if a:current
            let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
        endif

        let l:s .= '%='
        if a:current
            let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
            let l:s .= crystalline#left_mode_sep('')
        endif
        if a:width > 80
            let l:s .= ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
        else
            let l:s .= ' '
        endif

        return l:s
        endfunction

        function! TabLine()
        let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
        return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
        endfunction

        let g:crystalline_enable_sep = 0
        let g:crystalline_statusline_fn = 'StatusLine'
        let g:crystalline_tabline_fn = 'TabLine'
        let g:crystalline_theme = 'gruvbox'
    endif

        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_space_guides = 1

    let g:rainbow_active = 1

    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'
    nnoremap <silent><leader>f :FZF --reverse<CR>

    if has('nvim')
        function! FzyCommand(choice_command, vim_command) abort
            let l:callback = {
                        \ 'window_id': win_getid(),
                        \ 'filename': tempname(),
                        \  'vim_command':  a:vim_command
                        \ }

            function! l:callback.on_exit(job_id, data, event) abort
                bdelete!
                call win_gotoid(self.window_id)
                if filereadable(self.filename)
                    try
                        let l:selected_filename = readfile(self.filename)[0]
                        exec self.vim_command . l:selected_filename
                    catch /E684/
                    endtry
                endif
                call delete(self.filename)
            endfunction

            botright 10 new
            let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
            silent call termopen(l:term_command, l:callback)
            setlocal nonumber norelativenumber
            startinsert
        endfunction
    else
        function! FzyCommand(choice_command, vim_command)
            try
                let output = system(a:choice_command . " | fzy ")
            catch /Vim:Interrupt/
                " Swallow errors from ^C, allow redraw! below
            endtry
            redraw!
            if v:shell_error == 0 && !empty(output)
                exec a:vim_command . ' ' . output
            endif
        endfunction
    endif

    nnoremap <silent><leader>t :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":tabedit")<cr>
    nnoremap <silent><leader>h :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":split")<cr>
    nnoremap <silent><leader>v :call FzyCommand("rg --files --hidden -g '!.git/*' .", ":vsplit")<cr>

    if has('nvim')
        command! SW write suda://%
    endif

    if s:is_ide
        function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        let g:coc_snippet_next = '<tab>'
        let g:coc_snippet_prev = '<S-TAB>'

        " Use <c-space> for trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

        " Use `[c` and `]c` for navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K for show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
        if &filetype == 'vim'
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
        endfunction

        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)


        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        vmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        if has('nvim')
            let g:vimtex_compiler_progname='nvr'
        endif
        let g:vimtex_format_enabled=1
        let g:vimtex_quickfix_autojump=1
        let g:vimtex_quickfix_autoclose_after_keystrokes=3
        let g:vimtex_view_method='zathura'
        let g:vimtex_complete_img_use_tail=1
        let g:vimtex_compiler_latexmk = {
            \  'callback' : 0,
            \}
        nnoremap <localleader>lt :call vimtex#fzf#run()<cr>
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'python': ['add_blank_lines_for_python_control_statements', 'autopep8', 'isort', 'yapf',],
        \}
        let g:ale_cpp_ccls_init_options = {
        \   'cache': {
        \       'directory': '/tmp/ccls/cache',
        \   },
        \ }

        let g:ale_completion_enabled = 1

        " Set this variable to 1 to fix files when you save them.
        let g:ale_fix_on_save = 1
    endif

endif

if has("autocmd")
    if s:is_ide && s:use_plugins
        augroup coc
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
            autocmd FileType json syntax match Comment +\/\/.\+$+
            autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
            " Highlight symbol under cursor on CursorHold
            autocmd CursorHold * silent call CocActionAsync('highlight')
        augroup end
    endif

    augroup commentary
        autocmd!
        autocmd FileType cpp setlocal commentstring=//\ %s
        autocmd FileType cfg setlocal commentstring=#\ %s
        autocmd FileType xdefaults setlocal commentstring=!\ %s
    augroup end

    augroup writting_autocmd
        autocmd!
        autocmd FileType markdown let &makeprg="pandoc '%' -o '%:r'.pdf"
        autocmd FileType markdown,text,tex setlocal spell
        autocmd FileType markdown,text,tex setlocal complete+=kspell
    augroup END

"" Remember cursor position
    augroup vimrc-remember-cursor-position
        autocmd!
        " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
        autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
    augroup END

    augroup git
        autocmd!
        autocmd FileType gitcommit setlocal textwidth=79
        autocmd FileType gitcommit setlocal formatoptions+=t
        autocmd FileType gitcommit setlocal spell
        autocmd FileType gitcommit setlocal complete+=kspell
        autocmd FileType gitcommit match ErrorMsg /\%1l.\%>81v/
        autocmd FileType gitcommit exec 'normal gg' | startinsert!
    augroup END

    augroup ft_detection
        autocmd!
        autocmd BufNewFile,BufRead ~/.config/i3/config setlocal filetype=i3config
        autocmd BufNewFile,BufRead ~/.i3/config setlocal filetype=i3config
        autocmd BufNewFile,BufRead ~/dotfiles/i3/.config/i3/config setlocal filetype=i3config
        autocmd BufNewFile,BufRead *sxhkrc setlocal filetype=sxhkd
        autocmd BufNewFile,BufRead *.cls setlocal filetype=tex
    augroup END

    augroup no_autoformat
        autocmd!
        autocmd FileType i3config setlocal formatoptions-=t
        autocmd FileType sh setlocal formatoptions-=t
    augroup END

    if s:use_plugins
        augroup vim_group
            autocmd!
            autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q | source $MYVIMRC
                \| endif
        augroup END
    endif

    augroup reload
        autocmd!
        autocmd BufWritePost *.vimrc,*init.vim source $MYVIMRC
        autocmd BufWritePost *.Xresources,*.Xdefaults !xrdb %
        autocmd BufWritePost *config.h !make clean install
        autocmd BufWritePost ~/.config/i3/config !i3-msg reload
        autocmd BufWritePost ~/.i3/config !i3-msg reload
        autocmd BufWritePost ~/dotfiles/i3/.config/i3/config !i3-msg reload
        autocmd BufWritePost ~/.config/i3blocks/config !i3-msg restart
        autocmd BufWritePost ~/dotfiles/i3blocks/.config/i3blocks/config !i3-msg restart
        autocmd BufWritePost *sxhkdrc !pkill -SIGUSR1 sxhkd
        autocmd BufWritePost *dunstrc !systemctl --user restart dunst
        autocmd BufWritePost *.Xkeymap !xkbcomp ~/.Xkeymap $DISPLAY
        autocmd BufWritePost *.Xmodmap !xmodmap ~/.Xmodmap
    augroup END
endif
