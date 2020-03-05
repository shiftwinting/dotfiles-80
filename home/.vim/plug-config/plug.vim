if !g:use_plugins || exists('g:loaded_plug_config')
    finish
endif
let g:loaded_plug_config = 1

augroup plug
    autocmd!
    autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | quit
        \| endif
augroup END

command! PU PlugUpdate | PlugUpgrade
