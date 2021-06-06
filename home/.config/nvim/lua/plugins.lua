local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd [[packadd packer.nvim]]

vim.api.nvim_command [[autocmd BufWritePost plugins PackerCompile]]

return require('packer').startup({
    function()
        -- Packer can manage itself as an optional plugin
        use {'wbthomason/packer.nvim', opt = true}
        use 'tjdevries/astronauta.nvim'
        use 'tpope/vim-repeat'
        use {
            'terrortylor/nvim-comment',
            config = function() require "cfg.comments" end
        }
        use 'tpope/vim-unimpaired'
        use 'tpope/vim-abolish'
        use {
            'tpope/vim-dispatch',
            config = function() require "cfg.dispatch" end
        }
        use 'tpope/vim-git'
        use 'tpope/vim-rsi'
        use 'tpope/vim-surround'
        use 'tpope/vim-apathy'
        use 'tpope/vim-obsession'
        use {'ilyachur/cmake4vim', config = function()
            require "cfg.cmake"
        end}
        use {
            'andymass/vim-matchup',
            config = function() require "cfg.matchup" end
        }
        use {'romainl/vim-qf', config = function() require "cfg.qf" end}
        use {
            'npxbr/gruvbox.nvim',
            config = function() require "cfg.gruvbox" end,
            requires = 'rktjmp/lush.nvim'
        }
        use {
            'luochen1990/rainbow',
            config = function() require "cfg.rainbow" end
        }
        use 'justinmk/vim-sneak'
        use 'editorconfig/editorconfig-vim'
        use 'michaeljsmith/vim-indent-object'
        use 'wellle/targets.vim'
        use 'rhysd/clever-f.vim'
        use 'lambdalisue/suda.vim'
        use 'kovetskiy/sxhkd-vim'
        use 'tmux-plugins/vim-tmux'
        use {
            'numToStr/Navigator.nvim',
            config = function() require "cfg.tmux" end
        }
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
        use {
            'norcalli/nvim-colorizer.lua',
            config = function() require"colorizer".setup() end
        }
        use {
            'hrsh7th/vim-vsnip',
            config = function() require "cfg.snippets" end,
            requires = {
                'hrsh7th/vim-vsnip-integ', 'one-harsh/vscode-cpp-snippets',
                'kitagry/vs-snippets', 'rafamadriz/friendly-snippets'
            }
        }
        use {'neovim/nvim-lspconfig', config = function()
            require "cfg.lsp"
        end}
        use {
            'hrsh7th/nvim-compe',
            config = function() require "cfg.completion" end
        }
        use {
            'RishabhRD/nvim-lsputils',
            requires = {
                'RishabhRD/popfix',
                run = 'make -C external_modules/fzy_lua_native'
            }
        }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
            config = function() require "cfg.ts" end,
            requires = {
                'nvim-treesitter/nvim-treesitter-refactor',
                'nvim-treesitter/nvim-treesitter-textobjects',
                'romgrk/nvim-treesitter-context', 'p00f/nvim-ts-rainbow',
                'bryall/contextprint.nvim', 'theHamsta/nvim-treesitter-pairs',
                'haringsrob/nvim_context_vt'
            }
        }
        use 'antoinemadec/FixCursorHold.nvim'
        use {
            'mfussenegger/nvim-dap',
            config = function() require "cfg.dap" end,
            requires = {
                'theHamsta/nvim-dap-virtual-text',
                'mfussenegger/nvim-dap-python', 'jbyuki/lua-debug.nvim'
            }
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
                vim.g.polyglot_disabled = {
                    'latex', 'lua', 'tex', 'sxhkd', 'tmux', "sensible"
                }
            end
        }
        use {
            'nvim-telescope/telescope.nvim',
            config = function() require "cfg.telescope" end,
            requires = {
                'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', {
                    'nvim-telescope/telescope-fzy-native.nvim',
                    run = 'make -C deps/fzy-lua-native'
                }, 'nvim-telescope/telescope-dap.nvim'
            }
        }
        use {
            'lewis6991/gitsigns.nvim',
            config = function() require "cfg.gitsigns" end,
            requires = 'nvim-lua/plenary.nvim'
        }
        use {
            'pwntester/octo.nvim',
            requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
            cond = function() return vim.fn.executable("gh") == 1 end
        }
        use 'strboul/urlview.vim'
        use {
            'tjdevries/express_line.nvim',
            config = function() require "cfg.statusline" end,
            requires = 'nvim-lua/plenary.nvim'
        }
        use {
            'jdhao/better-escape.vim',
            config = function() vim.g.better_escape_shortcut = "jj" end
        }
        use {'monaqa/dial.nvim', config = function() require "cfg.dial" end}
        use {
            'kosayoda/nvim-lightbulb',
            config = function() require "cfg.lightbulb" end
        }
        use 'ray-x/lsp_signature.nvim'
        use 'jubnzv/virtual-types.nvim'
        use {
            'TimUntersberger/neogit',
            requires = {
                'nvim-lua/plenary.nvim', {
                    'sindrets/diffview.nvim',
                    config = function()
                        require'diffview'.setup {
                            file_panel = {use_icons = false}
                        }
                    end
                }
            },
            config = function()
                require"neogit".setup {integrations = {diffview = true}}
            end
        }
        use {
            'ruifm/gitlinker.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function() require "cfg.gitlinker" end
        }
        use {
            'simrat39/symbols-outline.nvim',
            config = function() require "cfg.symbols" end
        }
        use {
            'Pocco81/AbbrevMan.nvim',
            config = function() require "abbrev-man" end
        }
    end,
    config = {
        profile = {enable = true, threshold = 1},
        display = {open_cmd = 'new +only [packer]'}
    }
})
