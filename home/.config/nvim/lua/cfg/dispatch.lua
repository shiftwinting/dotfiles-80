local nmap = function(keys, expr, trail)
    trail = trail or "<cr>"
    vim.api.nvim_set_keymap('n', keys, ": " .. expr .. trail, {noremap = true})
end

nmap("m<cr>", "execute 'Make g:targets'")
nmap("m!", "execute 'Make! g:targets'")
nmap("m<space>", "Make<space>", "")
