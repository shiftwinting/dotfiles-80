let g:use_plugins = 1
let g:start = '/bin/bash'

let mapleader = ' '
let maplocalleader = ','

set statusline=
" filename
set statusline+=%f
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

if !has('nvim')
    set background=dark
    set runtimepath^=~/.config/nvim,~/.local/share/nvim/site
    set runtimepath+=~/.local/share/nvim/site/after,~/.config/nvim/after
    let &packpath = &runtimepath
endif

if has('termguicolors') && &term!="linux" && ($DISPLAY!="" || $SSH_TTY!="")
    if !has('nvim')
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
    set pumblend=20
endif

if g:use_plugins
    " separation point
    set statusline+=%=
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        if !executable('curl')
            echoerr 'You have to install curl or first install vim-plug yourself!'
            execute 'quit!'
        endif
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    function! Cond(cond, ...)
        let opts = get(a:000, 0, {})
        return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction
    let g:has_cpp_ls = executable('ccls') || executable('cquery')
    call plug#begin('~/.local/share/nvim/site/plugged')
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
    Plug 'tpope/vim-apathy'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'vhdirk/vim-cmake'
    Plug 'rhysd/vim-llvm'
    Plug 'andymass/vim-matchup'
    Plug 'haya14busa/incsearch.vim'
    Plug 'bkad/CamelCaseMotion'
    Plug 'romainl/vim-qf'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'luochen1990/rainbow'
    Plug 'justinmk/vim-sneak'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'wellle/targets.vim'
    Plug 'rhysd/clever-f.vim'
    Plug 'lambdalisue/suda.vim', Cond(has('nvim'))
    Plug 'glacambre/firenvim', Cond(has('nvim'), {'do': { _ -> firenvim#install(0)}})
    Plug 'markonm/traces.vim', Cond(!has('nvim'))
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dense-analysis/ale'
    Plug 'lervag/vimtex', {'for': 'tex'}
    Plug 'mzlogin/vim-markdown-toc'
    Plug 'rhysd/git-messenger.vim'
    Plug 'kana/vim-textobj-user'
        Plug 'Julian/vim-textobj-variable-segment'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    Plug 'machakann/vim-highlightedyank', Cond(!has('nvim-0.5'))
    Plug 'norcalli/nvim-colorizer.lua', Cond(has('nvim-0.4'))
    Plug 'honza/vim-snippets'
        Plug 'SirVer/ultisnips'
    Plug 'prabirshrestha/asyncomplete.vim', Cond(!has('nvim-0.5'))
        Plug 'yami-beta/asyncomplete-omni.vim', Cond(!has('nvim-0.5'))
        Plug 'prabirshrestha/asyncomplete-file.vim', Cond(!has('nvim-0.5'))
        Plug 'prabirshrestha/asyncomplete-ultisnips.vim', Cond(!has('nvim-0.5'))
        Plug 'prabirshrestha/asyncomplete-lsp.vim', Cond(!has('nvim-0.5'))
    Plug 'prabirshrestha/vim-lsp', Cond(!has('nvim-0.5'))
        Plug 'thomasfaingnaert/vim-lsp-snippets', Cond(!has('nvim-0.5'))
        Plug 'thomasfaingnaert/vim-lsp-ultisnips', Cond(!has('nvim-0.5'))
        Plug 'mattn/vim-lsp-settings', Cond(!has('nvim-0.5'))
    Plug 'jackguo380/vim-lsp-cxx-highlight', Cond(g:has_cpp_ls, {'for': 'cpp'})
    Plug 'neovim/nvim-lsp', Cond(has('nvim-0.5'))
        Plug 'haorenW1025/completion-nvim', Cond(has('nvim-0.5'))
            Plug 'vigoux/completion-treesitter', Cond(has('nvim-0.5'))
            Plug 'steelsojka/completion-buffers', Cond(has('nvim-0.5'))
        Plug 'haorenW1025/diagnostic-nvim', Cond(has('nvim-0.5'))
    Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim-0.5'))
    " Plug 'nvim-lua/lsp-status.nvim', Cond(has('nvim-0.5'))
    call plug#end()
    runtime! plug-config/**.vim
    if has('nvim-0.5')
		luafile ~/.config/nvim/init.lua
	endif
endif

set exrc
set secure
