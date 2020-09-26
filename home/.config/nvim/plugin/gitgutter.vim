if !g:use_plugins || exists('g:loaded_gitgutter_config')
    finish
endif
let g:loaded_gitgutter_config = 1

let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_highlight_linenrs = 1

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d~%d-%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

function! GitGutterPrevHunkCycle()
  let line = line('.')
  silent! GitGutterPrevHunk
  if line('.') == line
    normal! G
    GitGutterNextHunk
  endif
endfunction

function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      1
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

nnoremap <silent> ]c :call GitGutterNextHunkCycle()<CR>
nnoremap <silent> [c :call GitGutterPrevHunkCycle()<CR>
nnoremap <silent> [C :call PrevHunkAllBuffers()<CR>
nnoremap <silent> ]C :call NextHunkAllBuffers()<CR>

function! GlobalChangedLines(ex_cmd)
  for hunk in GitGutterGetHunks()
    for lnum in range(hunk[2], hunk[2]+hunk[3]-1)
      let cursor = getcurpos()
      silent! execute lnum.a:ex_cmd
      call setpos('.', cursor)
    endfor
  endfor
endfunction

command -nargs=1 Glines call GlobalChangedLines(<q-args>)
