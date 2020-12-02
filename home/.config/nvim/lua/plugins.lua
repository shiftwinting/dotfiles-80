local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd [[packadd packer.nvim]]

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
    use {
        'npxbr/gruvbox.nvim',
        config = function() require "cfg.gruvbox" end,
        requires = 'tjdevries/colorbuddy.nvim'
    }
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
    use {'norcalli/nvim-colorizer.lua', require"colorizer".setup()}
    use {'SirVer/ultisnips', requires = 'honza/vim-snippets'}
    use {'neovim/nvim-lspconfig', config = function() require "cfg.lsp" end}
    use {
        'nvim-lua/completion-nvim',
        requires = 'nvim-treesitter/completion-treesitter'
    }
    use {
        'RishabhRD/nvim-lsputils',
        config = function() require "cfg.lsputil" end,
        requires = 'RishabhRD/popfix'
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require "cfg.ts" end,
        requires = {
            {
                'nvim-treesitter/completion-treesitter',
                requires = 'nvim-lua/completion-nvim'
            }, 'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            {'romgrk/nvim-treesitter-context', disable = true},
            'p00f/nvim-ts-rainbow', 'bryall/contextprint.nvim'
        }
    }
    use 'antoinemadec/FixCursorHold.nvim'
    use {
        'mfussenegger/nvim-dap',
        config = function() require "cfg.dap" end,
        requires = 'theHamsta/nvim-dap-virtual-text'
    }
    use 'rickhowe/diffchar.vim'
    use 'rhysd/conflict-marker.vim'
    use {
        'glepnir/indent-guides.nvim',
        config = function() require "cfg.indent_guides" end
    }
    use {
        'sheerun/vim-polyglot',
        setup = function()
            vim.g.polyglot_disabled = {'latex', 'lua', 'tex', 'sxhkd', 'tmux'}
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require "cfg.telescope" end,
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-telescope/telescope-dap.nvim'
        }
    }
    use 'romgrk/barbar.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require "cfg.gitsigns" end,
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'pwntester/octo.nvim'
    use 'strboul/urlview.vim'
    use {
        'tjdevries/express_line.nvim',
        config = function() require "cfg.statusline" end,
        requires = 'nvim-lua/plenary.nvim'
    }
    use {'dstein64/vim-startuptime', disable = true}
end)
