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
    use 'tpope/vim-repeat'
    use 'tpope/vim-obsession'
    use 'tpope/vim-commentary'
    use 'tpope/vim-unimpaired'
    use 'benmills/vimux'
    use 'tpope/vim-abolish'
    use {'tpope/vim-dispatch', config = function() require "cfg.dispatch" end}
    use 'tpope/vim-git'
    use {
        'tpope/vim-fugitive',
        requires = {'junegunn/gv.vim', 'tpope/vim-rhubarb'}
    }
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'tpope/vim-apathy'
    use {'ilyachur/cmake4vim', config = function() require "cfg.cmake" end}
    use {'andymass/vim-matchup', config = function() require "cfg.matchup" end}
    use {'romainl/vim-qf', config = function() require "cfg.qf" end}
    use {
        'npxbr/gruvbox.nvim',
        config = function() require "cfg.gruvbox" end,
        requires = 'tjdevries/colorbuddy.nvim'
    }
    use {'luochen1990/rainbow', config = function() require "cfg.rainbow" end}
    use 'justinmk/vim-sneak'
    use {
        'editorconfig/editorconfig-vim',
        config = function()
            vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}
        end
    }
    use 'michaeljsmith/vim-indent-object'
    use 'wellle/targets.vim'
    use 'rhysd/clever-f.vim'
    use 'lambdalisue/suda.vim'
    use 'kovetskiy/sxhkd-vim'
    use 'tmux-plugins/vim-tmux'
    use 'christoomey/vim-tmux-navigator'
    use {
        'lervag/vimtex',
        ft = 'tex',
        config = function() require "cfg.vimtex" end
    }
    use {
        'Julian/vim-textobj-variable-segment',
        requires = 'kana/vim-textobj-user'
    }
    use {'mzlogin/vim-markdown-toc', ft = 'markdown'}
    use {'npxbr/glow.nvim', ft = 'markdown'}
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require"colorizer".setup() end
    }
    use {
        'SirVer/ultisnips',
        config = function() require "cfg.ultisnips" end,
        requires = 'honza/vim-snippets'
    }
    use {'neovim/nvim-lspconfig', config = function() require "cfg.lsp" end}
    use {
        'nvim-lua/completion-nvim',
        config = function() require "cfg.completion" end,
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
            vim.g.loaded_sensible = 1
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
    use {'romgrk/barbar.nvim', setup = function() require "cfg.barbar" end}
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require "cfg.gitsigns" end,
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        'pwntester/octo.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
    }
    use 'strboul/urlview.vim'
    use {
        'tjdevries/express_line.nvim',
        config = function() require "cfg.statusline" end,
        requires = 'nvim-lua/plenary.nvim'
    }
end)
