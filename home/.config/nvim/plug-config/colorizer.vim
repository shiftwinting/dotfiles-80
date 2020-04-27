if !g:use_plugins || exists('g:loaded_colorizer_config') || !has('nvim-0.4') || &term=="linux" || ($DISPLAY=="" && $SSH_TTY=="")
    finish
endif
let g:loaded_colorizer_config = 1

lua <<
if jit ~= nil then
    require'colorizer'.setup()
end
.
