let g:use_plugins = 1
let g:is_ide = 1
let g:use_crystalline = 1

if !g:use_plugins
    let g:is_ide = 0
    let g:use_crystalline = 0
endif

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

if g:use_plugins
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
    Plug 'tpope/vim-scriptease'
    Plug 'machakann/vim-sandwich'
    Plug 'gruvbox-community/gruvbox'
    if g:use_crystalline
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
    Plug 'tmux-plugins/vim-tmux'
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
    if g:is_ide
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
    endif
    " Initialize plugin system
    call plug#end()
endif

runtime! plug-config/**/*.vim
