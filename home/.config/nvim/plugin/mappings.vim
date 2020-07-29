scriptencoding 'utf-8'
if exists('g:loaded_mappings')
    finish
endif
let g:loaded_mappings = 1

nnoremap <silent> <Space> <Nop>

" Don't use Ex mode, use Q for running macros
nnoremap Q @q

" make an accidental ; press also enter command mode
" temporarily disabled to to vim-sneak plugin
" nnoremap ; :

" Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
" but not Vi-compatible), rather than act as yy
nnoremap <silent> Y y$

" highlight last inserted text
nnoremap <silent> gV `[v`]

nnoremap <silent> <down> <c-e>
nnoremap <silent> <up> <c-y>
" go to first non-blank character of current line
nnoremap <silent> <c-a> ^
vnoremap <silent> <c-a> ^
nnoremap <silent> <c-e> $
vnoremap <silent> <c-e> $

" This extends p in visual mode (note the noremap), so that if you paste from
" the unnamed (ie. default) register, that register content is not replaced by
" the visual selection you just pasted over–which is the default behavior.
" This enables the user to yank some text and paste it over several places in
" a row, without using a named register
" vnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>
vnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>

vnoremap <silent> <leader>p "_dP
nnoremap <silent> <leader>p "_dP
noremap <silent> <leader>c "_c
noremap <silent> <leader>C "_C

" Find and Replace binds
nnoremap <leader>s :<c-u>%s/
vnoremap <leader>s :s/
nnoremap <leader>gs :<c-u>%s/<c-r>"/
vnoremap <leader>gs :s/<c-r>"/
nnoremap <Leader>S :%s/\<<C-r><C-w>\>/

nnoremap <silent> <leader>x :wall<cr>
nnoremap <silent> <leader>z :wqall<cr>
nnoremap <silent> <leader>q :quitall<cr>
nnoremap <silent> <localleader>x :update<cr>
nnoremap <silent> <localleader>q :quit<cr>

tnoremap <silent><expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

inoremap <silent> jj <esc>
inoremap <silent> kk <esc>
inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

if !has('nvim-0.5')
    inoremap <silent> <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
endif

if !has('nvim')
    command! SW :w !sudo tee % > /dev/null
endif

nnoremap <leader>h :write <bar> edit <bar> TSBufEnable highlight<cr>
