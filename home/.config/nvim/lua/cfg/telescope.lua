local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local map = require("mapper")

require("telescope").setup({
    defaults = {
        color_devicons = false,
        prompt_position = "top",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        selection_strategy = "follow",
        generic_sorter = sorters.get_fzy_sorter,
        file_sorter = sorters.get_fzy_sorter,
        mappings = {
            i = {
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
            },
        },
    },
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("dap")

local telescope_map = function(keys, func, mod)
    mod = mod or ".builtin"
    map.nlua(
        "<localleader>" .. keys,
        "require'telescope." .. mod .. "'." .. func
    )
end

telescope_map("p", "planets()")
telescope_map("B", "builtin()")

telescope_map("/", "live_grep()")
telescope_map("?", "grep_string()")
telescope_map(
    "f",
    'find_files{find_command = {"fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git"}}'
)
telescope_map("b", "buffers{sort_lastused = true}")

telescope_map("t", "treesitter()")

telescope_map("s", "lsp_document_symbols()")
telescope_map("S", "lsp_workspace_symbols()")
telescope_map("r", 'lsp_references{ initial_mode = "normal" }')
telescope_map("a", "lsp_code_actions()")
telescope_map("A", "lsp_range_code_actions()")

telescope_map("c", "commands()")
telescope_map("h", "help_tags()")
telescope_map("m", "man_pages()")
telescope_map("k", "keymaps()")
telescope_map("Q", 'quickfix{ initial_mode = "normal" }')
telescope_map("L", 'loclist{ initial_mode = "normal" }')
telescope_map("R", 'registers{ initial_mode = "normal" }')
telescope_map("A", "autocommands()")

telescope_map("gs", 'git_status{ initial_mode = "normal" }')
telescope_map("gb", "git_branches()")
telescope_map("gc", "git_commits()")
telescope_map("gC", "git_bcommits()")

telescope_map("dc", "extensions.dap.commands()", "")
telescope_map(
    "dC",
    'extensions.dap.configurations{ initial_mode = "normal" }',
    ""
)
telescope_map(
    "db",
    'extensions.dap.list_breakpoints{ initial_mode = "normal" }',
    ""
)
telescope_map("dv", "extensions.dap.variables()", "")
