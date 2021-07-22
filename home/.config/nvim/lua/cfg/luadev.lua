local luadev = require("lua-dev").setup({
    lspconfig = {
        cmd = { "lua-language-server" },
    },
})

require("lspconfig").sumneko_lua.setup(luadev)
