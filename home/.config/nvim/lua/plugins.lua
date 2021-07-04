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
                require("plugins")
            end,
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
        use({ "tpope/vim-repeat", keys = { "n", "." } })
        use({
            "terrortylor/nvim-comment",
            keys = { { "n", "gc" }, { "v", "gc" } },
            config = function()
                require("cfg.comments")
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
                require("cfg.dispatch")
            end,
        })
        use("tpope/vim-rsi")
        use({
            "blackCauldron7/surround.nvim",
            keys = {
                { "n", "sr" },
                { "n", "sd" },
                { "n", "ys" },
                { "v", "s" },
                { "i", "<c-s>" },
            },
            config = function()
                require("surround").setup({})
            end,
        })
        use("tpope/vim-apathy")
        use({ "tpope/vim-obsession", cmd = "Obsession" })
        use({
            "andymass/vim-matchup",
            event = "CursorMoved",
            config = function()
                require("cfg.matchup")
            end,
        })
        use({
            "romainl/vim-qf",
            config = function()
                require("cfg.qf")
            end,
        })
        use({
            "npxbr/gruvbox.nvim",
            event = "VimEnter",
            config = function()
                require("cfg.gruvbox")
            end,
            requires = "rktjmp/lush.nvim",
        })
        use({
            "luochen1990/rainbow",
            event = "BufRead",
            config = function()
                require("cfg.rainbow")
            end,
        })
        use("editorconfig/editorconfig-vim")
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
                require("cfg.tmux")
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
            "neovim/nvim-lspconfig",
            event = "BufRead",
            config = function()
                require("cfg.lsp")
            end,
            requires = {
                {
                    "RishabhRD/nvim-lsputils",
                    requires = {
                        "RishabhRD/popfix",
                        run = "make -C external_modules/fzy_lua_native",
                    },
                },
                "ray-x/lsp_signature.nvim",
                "doums/lsp_spinner.nvim",

                {
                    "kosayoda/nvim-lightbulb",
                    config = function()
                        require("cfg.lightbulb")
                    end,
                },
                "jubnzv/virtual-types.nvim",

                {
                    "simrat39/symbols-outline.nvim",
                    config = function()
                        require("cfg.symbols")
                    end,
                },
                "jose-elias-alvarez/null-ls.nvim",
            },
        })
        use({
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("cfg.completion")
            end,
            requires = {
                "hrsh7th/vim-vsnip",
                event = "InsertCharPre",
                config = function()
                    require("cfg.snippets")
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
            run = ":TSUpdate",
            config = function()
                require("cfg.ts")
            end,
        })
        use({
            "romgrk/nvim-treesitter-context",
            event = "BufRead",
            after = "ts",
        })
        use({
            "nvim-treesitter/nvim-treesitter-refactor",
            event = "BufRead",
            after = "ts",
        })
        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            event = "BufRead",
            after = "ts",
        })
        use({
            "p00f/nvim-ts-rainbow",
            event = "BufRead",
            after = "ts",
        })
        use({
            "bryall/contextprint.nvim",
            keys = { "n", "<leader>p" },
            after = "ts",
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
            after = "ts",
        })
        use({
            "RRethy/nvim-treesitter-textsubjects",
            event = "BufRead",
            after = "ts",
        })

        use({
            "theHamsta/nvim-treesitter-pairs",
            event = "BufRead",
            after = "ts",
        })
        use({
            "jghauser/follow-md-links.nvim",
            ft = "markdown",
            after = "ts",
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
                require("cfg.dap")
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
            "nvim-lua/plenary.nvim",
            as = "plenary",
            module = "plenary",
        })
        use({
            "nvim-telescope/telescope.nvim",
            keys = { "n", "<localleader>" },
            config = function()
                require("cfg.telescope")
            end,
            requires = {
                "plenary",
                "nvim-lua/popup.nvim",
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
                require("cfg.gitsigns")
            end,
            requires = "plenary",
        })
        use({
            "pwntester/octo.nvim",
            cmd = "Octo",
            requires = { "nvim-lua/popup.nvim", "plenary" },
        })
        use({
            "tjdevries/express_line.nvim",
            event = "VimEnter",
            config = function()
                require("cfg.statusline")
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
                require("cfg.dial")
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
                require("cfg.neogit")
            end,
        })
        use({
            "ruifm/gitlinker.nvim",
            keys = {
                { "n", "<leader>gy" },
                { "v", "<leader>gy" },
            },
            requires = "plenary",
            config = function()
                require("cfg.gitlinker")
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
        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

        use("tpope/vim-git")
        use("kovetskiy/sxhkd-vim")
        use("tmux-plugins/vim-tmux")
        use({
            "lervag/vimtex",
            ft = "tex",
            config = function()
                require("cfg.vimtex")
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
