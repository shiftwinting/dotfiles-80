let g:use_plugins = 1
let g:is_ide = 1

if !g:use_plugins
    let g:is_ide = 0
endif

let mapleader = "\<Space>"
let maplocalleader = ","
let g:start = '/bin/bash'

if g:use_plugins
    if empty(glob('~/.vim/autoload/plug.vim'))
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            execute "q!"
        endif
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-scriptease'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'haya14busa/incsearch.vim'
    Plug 'bkad/CamelCaseMotion'
    Plug 'romainl/vim-qf'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
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
    Plug 'lifepillar/vim-mucomplete'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'rhysd/git-messenger.vim'
    if g:is_ide
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'dense-analysis/ale'
        Plug 'lervag/vimtex'
    endif
    " Initialize plugin system
    call plug#end()
    runtime! plug-config/basic/**.vim
    if g:is_ide
        runtime! plug-config/ide/**.vim
    end
endif

set exrc
set secure
