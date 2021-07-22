local map = require("mapper")
local ncmd = map.ncmd
local vcmd = map.vcmd
local bufnr = vim.api.nvim_buf_get_number(0)

ncmd("gc", "Cycle", bufnr)
ncmd("gp", "Pick", bufnr)
ncmd("ge", "Edit", bufnr)
ncmd("gf", "Fixup", bufnr)
ncmd("gd", "Drop", bufnr)
ncmd("gs", "Squash", bufnr)
ncmd("gr", "Reword", bufnr)

vcmd("gc", "Cycle", bufnr)
vcmd("gp", "Pick", bufnr)
vcmd("ge", "Edit", bufnr)
vcmd("gf", "Fixup", bufnr)
vcmd("gd", "Drop", bufnr)
vcmd("gs", "Squash", bufnr)
vcmd("gr", "Reword", bufnr)
