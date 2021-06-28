local neogit = require("neogit")
local map = require("mapper")

neogit.setup({
    disable_commit_confirmation = true,
    integrations = { diffview = true },
})

vim.api.nvim_command([[ command! -nargs=* G lua require'neogit'.open(vim.tbl_deep_extend("force",{kind = 'split'}, require'neogit.lib.util'.parse_command_args(<f-args>)))<CR> ]])

map.nlua("<leader>ng", "require'neogit'.open{kind = 'split'}")
