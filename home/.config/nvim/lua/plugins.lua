local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.api.nvim_command([[packadd packer.nvim]])
end

return require("packer").startup({
    function()
        use({
            "wbthomason/packer.nvim",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/plugins.lua")
            end,
            module = "packer",
            cmd = {
                "PackerCompile",
                "PackerInstall",
                "PackerUpdate",
                "PackerClean",
                "PackerSync",
                "PackerStatus",
                "PackerLoad",
                "PackerProfile",
            },
        })
        use({
            "nvim-lua/plenary.nvim",
            as = "plenary",
            module = "plenary",
        })
        use({
            "nvim-lua/popup.nvim",
            as = "popup",
            module = "popup",
        })
        use({ "tpope/vim-repeat", keys = { "n", "." } })
        use({
            "terrortylor/nvim-comment",
            keys = { { "n", "gc" }, { "v", "gc" } },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/comments.lua")
            end,
        })
        use({
            "tpope/vim-unimpaired",
            keys = {
                { "n", "]" },
                { "n", "[" },
                { "n", "yo" },
            },
        })
        use("tpope/vim-abolish")
        use({
            "tpope/vim-dispatch",
            cmd = { "Dispatch", "Make", "Focus", "Start" },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/dispatch.lua")
            end,
        })
        use("tpope/vim-rsi")
        use({
            "blackCauldron7/surround.nvim",
            config = function()
                require("surround").setup({
                    pairs = {
                        nestable = {
                            { "(", ")" },
                            { "[", "]" },
                            { "{", "}" },
                            { "<", ">" },
                        },
                        linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
                    },
                })
            end,
        })
        use("tpope/vim-apathy")
        use({
            "folke/persistence.nvim",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/session.lua")
            end,
        })
        use({
            "andymass/vim-matchup",
            event = "CursorMoved",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/matchup.lua")
            end,
        })
        use({
            "romainl/vim-qf",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/qf.lua")
            end,
        })
        use({
            "npxbr/gruvbox.nvim",
            event = "VimEnter",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/gruvbox.lua")
            end,
            requires = "rktjmp/lush.nvim",
        })
        use({
            "luochen1990/rainbow",
            event = "BufRead",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/rainbow.lua")
            end,
        })
        use("michaeljsmith/vim-indent-object")
        use("wellle/targets.vim")
        use({
            "aserowy/tmux.nvim",
            keys = {
                { "n", "<c-h>" },
                { "n", "<c-j>" },
                { "n", "<c-k>" },
                { "n", "<c-l>" },
            },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/tmux.lua")
            end,
        })
        use({
            "Julian/vim-textobj-variable-segment",
            requires = "kana/vim-textobj-user",
        })
        use({ "mzlogin/vim-markdown-toc", ft = "markdown" })
        use({
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
            end,
        })

        use({
            "ray-x/lsp_signature.nvim",
            module = "lsp_signature",
        })
        use({
            "doums/lsp_spinner.nvim",
            module = "lsp_spinner",
        })
        use({
            "jubnzv/virtual-types.nvim",
            module = "virtualtypes",
        })
        use({
            "neovim/nvim-lspconfig",
            as = "lspconfig",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/lsp.lua")
            end,
        })

        use({
            "RishabhRD/nvim-lsputils",
            event = "BufRead",
            requires = {
                "RishabhRD/popfix",
                run = "make -C external_modules/fzy_lua_native",
            },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/lsputils.lua")
            end,
        })
        use({
            "jose-elias-alvarez/null-ls.nvim",
            event = "BufRead",
            requires = {
                "lspconfig",
                "plenary",
            },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/null.lua")
            end,
        })
        use({
            "folke/lua-dev.nvim",
            ft = "lua",
            requires = "lspconfig",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/luadev.lua")
            end,
        })
        use({
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/completion.lua")
            end,
            requires = {
                "hrsh7th/vim-vsnip",
                event = "InsertCharPre",
                config = function()
                    dofile(vim.fn.stdpath("config") .. "/lua/cfg/snippets.lua")
                end,
                requires = {
                    "hrsh7th/vim-vsnip-integ",
                    "one-harsh/vscode-cpp-snippets",
                    "kitagry/vs-snippets",
                    "rafamadriz/friendly-snippets",
                },
            },
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            as = "ts",
            event = "BufRead",
            module = "nvim-treesitter.ts_utils",
            run = ":TSUpdate",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/ts.lua")
            end,
        })
        use({
            "romgrk/nvim-treesitter-context",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "nvim-treesitter/nvim-treesitter-refactor",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "nvim-treesitter/nvim-tree-docs",
            event = "BufRead",
            requires = {
                "ts",
                { "Olical/aniseed", tag = "v3.20.0" },
            },
        })
        use({
            "p00f/nvim-ts-rainbow",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "bryall/contextprint.nvim",
            keys = { "n", "<leader>p" },
            requires = "ts",
            config = function()
                require("contextprint").setup()
                require("mapper").nlua(
                    "<leader>p",
                    'require"contextprint".add_statement()'
                )
            end,
        })
        use({
            "haringsrob/nvim_context_vt",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "RRethy/nvim-treesitter-textsubjects",
            event = "BufRead",
            after = "ts",
        })

        use({
            "theHamsta/nvim-treesitter-pairs",
            event = "BufRead",
            requires = "ts",
        })
        use({
            "jghauser/follow-md-links.nvim",
            event = "BufRead",
            requires = "ts",
            config = function()
                require("follow-md-links")
            end,
        })
        use({
            "lewis6991/spellsitter.nvim",
            event = "BufRead",
            config = function()
                require("spellsitter").setup()
            end,
        })

        use({
            "antoinemadec/FixCursorHold.nvim",
            event = { "CursorMoved", "CursorMovedI" },
        })
        use({
            "mfussenegger/nvim-dap",
            keys = { "<F5>", "<leader>lp", "gm", "g<cr>" },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/dap.lua")
            end,
            requires = {
                "theHamsta/nvim-dap-virtual-text",
                "rcarriga/nvim-dap-ui",
                "mfussenegger/nvim-dap-python",
                "jbyuki/one-small-step-for-vimkind",
            },
        })
        use({
            "rhysd/conflict-marker.vim",
            event = "BufRead",
            keys = {
                { "n", "[x" },
                { "n", "]x" },
                { "n", "co" },
                { "n", "ct" },
                { "n", "cb" },
                { "n", "cB" },
            },
        })
        use({
            "glepnir/indent-guides.nvim",
            event = "BufRead",
            config = function()
                require("cfg.indent_guides")
            end,
        })
        use({
            "nvim-telescope/telescope.nvim",
            as = "telescope",
            module = "telescope",
            keys = { "n", "<localleader>" },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/telescope.lua")
            end,
            requires = {
                "plenary",
                {
                    "nvim-telescope/telescope-fzy-native.nvim",
                    run = "make -C deps/fzy-lua-native",
                },
            },
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/gitsigns.lua")
            end,
            requires = "plenary",
        })
        use({
            "pwntester/octo.nvim",
            cmd = "Octo",
            requires = { "popup", "plenary", "telescope" },
            config = function()
                require("octo.config")._config.default_remote = {
                    "origin",
                    "upstream",
                }
            end,
        })
        use({
            "tjdevries/express_line.nvim",
            event = "VimEnter",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/statusline.lua")
            end,
            requires = "plenary",
        })
        use({
            "jdhao/better-escape.vim",
            keys = { "i", "jj" },
            config = function()
                vim.g.better_escape_shortcut = "jj"
            end,
        })
        use({
            "monaqa/dial.nvim",
            keys = {
                { "n", "]i" },
                { "n", "[i" },
            },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/dial.lua")
            end,
        })
        use({
            "TimUntersberger/neogit",
            cmd = { "Neogit", "G" },
            requires = {
                "plenary",
                {
                    "sindrets/diffview.nvim",
                    config = function()
                        require("diffview").setup({
                            file_panel = { use_icons = false },
                        })
                    end,
                },
            },
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/neogit.lua")
            end,
        })
        use({
            "ruifm/gitlinker.nvim",
            keys = {
                { "n", "<leader>g" },
                { "v", "<leader>g" },
            },
            requires = "plenary",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/gitlinker.lua")
            end,
        })
        use({
            "Pocco81/AbbrevMan.nvim",
            ft = { "text", "tex", "markdown", "lua", "python" },
            config = function()
                require("abbrev-man")
            end,
        })
        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install",
            ft = "markdown",
            config = function()
                vim.api.nvim_command([[
                    function! g:OpenNewWindow(url)
                        silent exec "Start! firefox --new-window " . a:url
                    endfunction
                    ]])
                vim.g.mkdp_browserfunc = "g:OpenNewWindow"
            end,
        })
        use({ "delphinus/agrp.nvim", module = "agrp" })
        use({ "ThePrimeagen/refactoring.nvim" })
        use({
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        })
        use("gpanders/editorconfig.nvim")
        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

        use("tpope/vim-git")
        use("kovetskiy/sxhkd-vim")
        use("tmux-plugins/vim-tmux")
        use({
            "lervag/vimtex",
            ft = "tex",
            config = function()
                dofile(vim.fn.stdpath("config") .. "/lua/cfg/vimtex.lua")
            end,
        })
        use("sudar/vim-arduino-syntax")
        use("chrisbra/csv.vim")
        use("martinda/Jenkinsfile-vim-syntax")
        use("rhysd/vim-llvm")
        use("MTDL9/vim-log-highlighting")
        use("chr4/nginx.vim")
        use("raimon49/requirements.txt.vim")
        use("wgwoods/vim-systemd-syntax")
        use({ "amadeus/vim-xml", ft = "xml" })
    end,
    config = {
        profile = { enable = false, threshold = 1 },
        display = { open_cmd = "new +only [packer]" },
    },
})
