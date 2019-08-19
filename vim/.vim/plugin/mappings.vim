if exists('g:loaded_mappings')
    finish
endif
let g:loaded_mappings = 1

nnoremap <Space> <Nop>

" Don't use Ex mode, use Q for running macros
nnoremap Q @q

" Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
" but not Vi-compatible), rather than act as yy
nnoremap Y y$

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


" highlight last inserted text
nnoremap gV `[v`]

" go to first non-blank character of current line
nnoremap S ^
nnoremap E $

nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>k

nnoremap <leader>go i<CR><esc>k

" nnoremap <silent><CR> :<C-U>nohlsearch<CR><CR>

" This extends p in visual mode (note the noremap), so that if you paste from
" the unnamed (ie. default) register, that register content is not replaced by
" the visual selection you just pasted over–which is the default behavior.
" This enables the user to yank some text and paste it over several places in
" a row, without using a named register (eg. "ay, "ap etc.).
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

nnoremap <leader>s :set spell!

"" Copy/Paste/Cut
" if has('unnamedplus')
"   set clipboard=unnamed,unnamedplus
" endif

nnoremap YY "+y<CR>
nnoremap <leader>p "+gP<CR>
nnoremap XX "+x<CR>

if has('nvim')
    nnoremap <M-l> gt
    nnoremap <M-h> gT
endif

set pastetoggle=<c-p>

" Find and Replace binds
nnoremap <leader>s :<c-u>%s/
xnoremap <leader>s :s/
nnoremap <Leader>S :%s/\<<C-r><C-w>\>/
