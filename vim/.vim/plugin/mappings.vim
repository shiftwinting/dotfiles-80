scriptencoding 'utf-8'
if exists('g:loaded_mappings')
    finish
endif
let g:loaded_mappings = 1

nnoremap <silent> <Space> <Nop>

" Don't use Ex mode, use Q for running macros
nnoremap Q @q

" make an accidental ; press also enter command mode
nnoremap ; :

" Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
" but not Vi-compatible), rather than act as yy
nnoremap <silent> Y y$

" highlight last inserted text
nnoremap <silent> gV `[v`]

nnoremap <silent> <down> <c-e>
nnoremap <silent> <up> <c-y>
" go to first non-blank character of current line
nnoremap <silent> <c-a> ^
nnoremap <silent> <c-e> $

" This extends p in visual mode (note the noremap), so that if you paste from
" the unnamed (ie. default) register, that register content is not replaced by
" the visual selection you just pasted over–which is the default behavior.
" This enables the user to yank some text and paste it over several places in
" a row, without using a named register (eg. "ay, "ap etc.).
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

set pastetoggle=<c-p>

" Find and Replace binds
nnoremap <leader>s :<c-u>%s/
xnoremap <leader>s :s/
nnoremap <Leader>S :%s/\<<C-r><C-w>\>/

nnoremap <silent> <leader>x :wall<cr>
nnoremap <silent> <leader>z :wqall<cr>
nnoremap <silent> <leader>q :quitall<cr>

tnoremap <Esc> <C-\><C-n>

inoremap jj <esc>
inoremap kk <esc>
inoremap jk <esc>
inoremap kj <esc>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
