require"gitlinker".setup({
    callbacks = {
        ["tau.hodor"] = function(url_data)
            url_data.host = "git.ruimarques.xyz"
            return require"gitlinker.hosts".get_gitea_type_url(url_data)
        end
    }
})
