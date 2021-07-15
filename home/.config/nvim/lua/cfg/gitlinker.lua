require("gitlinker").setup({
    callbacks = {
        ["tau.hodor"] = function(url_data)
            url_data.host = "git.ruimarques.xyz"
            return require("gitlinker.hosts").get_gitea_type_url(url_data)
        end,
    },
})

require("mapper").nlua(
    "<leader>gb",
    'require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})'
)
require("mapper").vlua(
    "<leader>gb",
    'require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})'
)
require("mapper").nlua("<leader>gY", 'require"gitlinker".get_repo_url()')
require("mapper").nlua(
    "<leader>gB",
    'require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})'
)
