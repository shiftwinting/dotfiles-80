let g:use_plugins = 1

let mapleader = ' '
let maplocalleader = ','

set statusline=
" tail of filename
set statusline+=%t
" [help] flag
set statusline+=\ %h
" modified flag
set statusline+=%m
" readonly flag
set statusline+=%r
" preview window flag
set statusline+=%w
" separation point
set statusline+=%=
set statusline+=%y
set statusline+=(%l/%L)
set statusline+=\ %P
" separation point
set statusline+=%=

if g:use_plugins
    if empty(glob('~/.vim/autoload/plug.vim'))
        if !executable('curl')
            echoerr 'You have to install curl or first install vim-plug yourself!'
            execute 'q!'
        endif
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-endwise'
    Plug 'rstacruz/vim-closer'
    Plug 'haya14busa/incsearch.vim'
    Plug 'bkad/CamelCaseMotion'
    Plug 'romainl/vim-qf'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'luochen1990/rainbow'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'wellle/targets.vim'
    Plug 'rhysd/clever-f.vim'
    if has('nvim')
        Plug 'lambdalisue/suda.vim'
    else
        Plug 'markonm/traces.vim'
    endif
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'mboughaba/i3config.vim'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'dag/vim-fish'
    if has('nvim-0.4')
        Plug 'norcalli/nvim-colorizer.lua'
    endif
    Plug 'machakann/vim-highlightedyank'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'rhysd/git-messenger.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    if executable('ctags') || executable('ctags-exuberant')
        Plug 'ludovicchabant/vim-gutentags'
    endif
    Plug 'dense-analysis/ale'
    Plug 'lervag/vimtex'
    call plug#end()
    runtime! plug-config/**.vim
endif

set exrc
set secure
