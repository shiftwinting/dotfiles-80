let g:use_plugins = 1

let g:polyglot_disabled = ['latex', 'lua', 'tex', 'sxhkd', 'tmux']

let mapleader = ' '
let maplocalleader = ','

set statusline=
set statusline+=%f
" [help] flag
set statusline+=\%h
" modified flag
set statusline+=%m
" readonly flag
set statusline+=%r
" preview window flag
set statusline+=%w
set statusline+=%y
" set statusline+=col:%c
" set statusline+=(%l/%L)
" set statusline+=\ %P
set statusline+=%=

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
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        if !executable('curl')
            echoerr 'You have to install curl or first install vim-plug yourself!'
            execute 'quit!'
        endif
        silent !curl -fLo '~/.local/share/nvim/site/autoload/plug.vim' --create-dirs
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    function! Cond(cond, ...)
        let opts = get(a:000, 0, {})
        return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction
    call plug#begin('~/.local/share/nvim/site/plugged')
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'benmills/vimux'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
        Plug 'junegunn/gv.vim'
        Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-apathy'
    Plug 'vhdirk/vim-cmake'
        Plug 'skywind3000/asyncrun.vim'
    Plug 'andymass/vim-matchup'
    Plug 'haya14busa/incsearch.vim'
    Plug 'romainl/vim-qf'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'airblade/vim-gitgutter'
    " Plug 'junegunn/fzf.vim'
    Plug 'luochen1990/rainbow'
    Plug 'justinmk/vim-sneak'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'wellle/targets.vim'
    Plug 'rhysd/clever-f.vim'
    Plug 'lambdalisue/suda.vim', Cond(has('nvim'))
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'lervag/vimtex', {'for': 'tex'}
    Plug 'rhysd/git-messenger.vim'
    Plug 'kana/vim-textobj-user'
        Plug 'Julian/vim-textobj-variable-segment'
    Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
    Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': 'markdown'}
    Plug 'norcalli/nvim-colorizer.lua', Cond(has('nvim-0.4'))
    Plug 'honza/vim-snippets'
        Plug 'SirVer/ultisnips'
    Plug 'neovim/nvim-lspconfig', Cond(has('nvim-0.5'))
        Plug 'nvim-lua/completion-nvim', Cond(has('nvim-0.5'))
            Plug 'steelsojka/completion-buffers', Cond(has('nvim-0.5'))
        Plug 'nvim-lua/diagnostic-nvim', Cond(has('nvim-0.5'))
        Plug 'nvim-lua/lsp-status.nvim', Cond(has('nvim-0.5'))
        Plug 'jackguo380/vim-lsp-cxx-highlight', Cond(has('nvim-0.5'))
    Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim-0.5'))
        " Plug 'nvim-lua/completion-nvim', Cond(has('nvim-0.5'))
            Plug 'nvim-treesitter/completion-treesitter', Cond(has('nvim-0.5'))
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'mfussenegger/nvim-dap', Cond(has('nvim-0.5'))
        Plug 'theHamsta/nvim-dap-virtual-text', Cond(has('nvim-0.5'))
    Plug 'rickhowe/diffchar.vim'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'Yggdroot/indentLine'
        Plug 'lukas-reineke/indent-blankline.nvim', Cond(has('nvim-0.5'))
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-lua/plenary.nvim', Cond(has('nvim-0.5'))
        Plug 'nvim-lua/popup.nvim', Cond(has('nvim-0.5'))
            Plug 'nvim-lua/telescope.nvim', Cond(has('nvim-0.5'))
    Plug 'dstein64/vim-startuptime'
    Plug 'tjdevries/nlua.nvim'
    Plug 'euclidianAce/BetterLua.vim'
    Plug 'norcalli/nvim_utils'
    Plug 'sbdchd/neoformat'
    call plug#end()
    if has('nvim-0.5')
        luafile ~/.config/nvim/init.lua
    endif
endif

set exrc
set secure
