require("persistence").setup()

nlua = require("mapper").nlua

nlua('<leader>ps', [[require("persistence").load()]])
nlua('<leader>pl', [[require("persistence").load(last=true)]])
nlua('<leader>pS', [[require("persistence").stop()]])
