if exists('g:loaded_gruvbox_config')
    finish
endif
let g:loaded_gruvbox_config = 1

if !has('nvim-0.5')
    let g:gruvbox_italic = 1
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_italicize_strings = 1
    let g:gruvbox_improved_strings = 0
    let g:gruvbox_improved_warnings = 1

    colorscheme gruvbox

    nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
    nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
    nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
endif
