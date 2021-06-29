local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown = {
    install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "markdown",
}

local tsconfigs = require("nvim-treesitter.configs")
tsconfigs.setup({
    ensure_installed = "all", -- one of "all", "language", or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = { enable = true },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
        smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                },
            },
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer",
            },
        },
    },
    rainbow = { enable = true },
    pairs = {
        enable = true,
        goto_right_end = false,
        fallback_cmd_normal = "call matchup#motion#find_matching_pair(0, 1)",
        keymaps = { goto_partner = "%" },
    },
    textsubjects = {
        enable = true,
        keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
})
