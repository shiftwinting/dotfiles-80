require("persistence").setup()

local nlua = require("mapper").nlua

nlua("<localleader>ss", [[require("persistence").load()]])
nlua("<localleader>sl", [[require("persistence").load({last=true})]])
nlua("<localleader>sS", [[require("persistence").stop()]])
