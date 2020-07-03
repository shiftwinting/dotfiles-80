if !g:use_plugins || exists('g:loaded_completion_nvim_config') || !has('nvim-0.5')
    finish
endif
let g:loaded_completion_nvim_config = 1

let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_enable_auto_hover = 0
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1
let g:completion_sorting = "length"
let g:completion_auto_change_source = 1

imap <c-j> <cmd>lua require'source'.prevCompletion()<CR> "use <c-j> to switch to previous completion
imap <c-k> <cmd>lua require'source'.nextCompletion()<CR> "use <c-k> to switch to next completion

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'complete_items': ['ts', 'path', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()
