if !g:use_plugins || exists('g:loaded_indent_line_config')
    finish
endif
let g:loaded_indent_line_config = 1

" let g:indentLine_setColors = 0
" let g:indentLine_setConceal = 0
let g:indent_blankline_space_char = '·'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indent_blankline_char =  '┊'
let g:indentLine_char =  '┊'
let g:indentLine_faster = 1