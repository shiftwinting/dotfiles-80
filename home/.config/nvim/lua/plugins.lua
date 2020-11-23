-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    local directory = string.format('%s/site/pack/packer/opt/',
                                    vim.fn.stdpath('data'))
    vim.fn.mkdir(directory, 'p')

    local out = vim.fn.system(string.format('git clone %s %s',
                                            'https://github.com/wbthomason/packer.nvim',
                                            directory .. '/packer.nvim'))

    print(out)
    print("Downloading packer.nvim...")

    return
end

vim.api.nvim_command [[autocmd BufWritePost plugins.lua PackerCompile]]

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
    use 'tpope/vim-sensible'
    use 'tpope/vim-repeat'
    use 'tpope/vim-obsession'
    use 'tpope/vim-commentary'
    use 'tpope/vim-unimpaired'
    use 'benmills/vimux'
    use 'tpope/vim-abolish'
    use 'tpope/vim-dispatch'
    use 'tpope/vim-git'
    use {
        'tpope/vim-fugitive',
        requires = {'junegunn/gv.vim', 'tpope/vim-rhubarb'}
    }
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'tpope/vim-apathy'
    use {'vhdirk/vim-cmake', requires = 'skywind3000/asyncrun.vim'}
    use 'andymass/vim-matchup'
    use 'haya14busa/incsearch.vim'
    use 'romainl/vim-qf'
    use {'npxbr/gruvbox.nvim', requires = 'tjdevries/colorbuddy.nvim'}
    use 'luochen1990/rainbow'
    use 'justinmk/vim-sneak'
    use 'editorconfig/editorconfig-vim'
    use 'michaeljsmith/vim-indent-object'
    use 'wellle/targets.vim'
    use 'rhysd/clever-f.vim'
    use 'lambdalisue/suda.vim'
    use 'kovetskiy/sxhkd-vim'
    use 'tmux-plugins/vim-tmux'
    use 'christoomey/vim-tmux-navigator'
    use {'lervag/vimtex', ft = 'tex'}
    use 'rhysd/git-messenger.vim'
    use {
        'Julian/vim-textobj-variable-segment',
        requires = 'kana/vim-textobj-user'
    }
    use {'mzlogin/vim-markdown-toc', ft = 'markdown'}
    use {'npxbr/glow.nvim', ft = 'markdown'}
    use 'norcalli/nvim-colorizer.lua'
    use {'SirVer/ultisnips', requires = 'honza/vim-snippets'}
    use 'neovim/nvim-lspconfig'
    use {
        'nvim-lua/completion-nvim',
        requires = {
            'steelsojka/completion-buffers',
            'nvim-treesitter/completion-treesitter'
        }
    }
    use {'RishabhRD/nvim-lsputils', requires = 'RishabhRD/popfix'}
    use {
        'nvim-treesitter/nvim-treesitter',
        lock = true,
        requires = {
            {
                'nvim-treesitter/completion-treesitter',
                requires = 'nvim-lua/completion-nvim'
            }, 'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            {'romgrk/nvim-treesitter-context', lock = true},
            'p00f/nvim-ts-rainbow', 'bryall/contextprint.nvim',
            {'p00f/nvim-ts-rainbow', disable = true}
        }
    }
    use 'antoinemadec/FixCursorHold.nvim'
    use {'mfussenegger/nvim-dap', requires = 'theHamsta/nvim-dap-virtual-text'}
    use 'rickhowe/diffchar.vim'
    use 'rhysd/conflict-marker.vim'
    use {
        'Yggdroot/indentLine',
        disable = true,
        requires = 'lukas-reineke/indent-blankline.nvim'
    }
    use 'glepnir/indent-guides.nvim'
    use 'sheerun/vim-polyglot'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    }
    use 'norcalli/nvim_utils'
    use 'romgrk/barbar.nvim'
    use {'Xuyuanp/scrollbar.nvim', disable = true}
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'pwntester/octo.nvim'
    use 'strboul/urlview.vim'
    use {'dstein64/vim-startuptime', disable = true}
end)
