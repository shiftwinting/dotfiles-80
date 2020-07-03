if !g:use_plugins || exists('g:loaded_gitgutter_config')
    finish
endif
let g:loaded_gitgutter_config = 1

let g:gitgutter_diff_args = '-w'
let g:gitgutter_highlight_linenrs = 1

" Your vimrc
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
