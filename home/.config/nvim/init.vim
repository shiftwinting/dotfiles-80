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
set statusline+=col:%c
set statusline+=(%l/%L)
set statusline+=\ %P
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

if has('nvim-0.5')
    luafile ~/.config/nvim/init.lua
    function! LspStatus() abort
        let sl = 'LSP '
        if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
            let sl.='E:'
            let sl.=luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), [[Error]])")
            let sl.='W:'
            let sl.=luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), [[Warning]])")
        else
            let sl.='off'
        endif
    return sl
    endfunction
    set statusline+=%{LspStatus()}
    set statusline+=%=
    set statusline+=%{get(b:,'gitsigns_status','')}
else
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
        Plug 'andymass/vim-matchup'
        Plug 'haya14busa/incsearch.vim'
        Plug 'romainl/vim-qf'
        Plug 'gruvbox-community/gruvbox'
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
        Plug 'npxbr/glow.nvim', {'for': 'markdown'}
        Plug 'norcalli/nvim-colorizer.lua', Cond(has('nvim-0.4'))
        Plug 'honza/vim-snippets'
            Plug 'SirVer/ultisnips'
        Plug 'rickhowe/diffchar.vim'
        Plug 'rhysd/conflict-marker.vim'
        Plug 'Yggdroot/indentLine'
        Plug 'sheerun/vim-polyglot'
        " Plug 'dstein64/vim-startuptime'
    call plug#end()
endif
