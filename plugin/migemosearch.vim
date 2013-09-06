if exists('g:loaded_migemosearch')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:migemosearch_cmigemo = get(g:, 'migemosearch_cmigemo', 'cmigemo')
let g:migemosearch_migemodict = get(g:, 'migemosearch_migemodict', '')
let g:migemosearch_use_kaoriya_migemo = get(g:, 'migemosearch_use_kaoriya_migemo', 0)

" use migemo when a romaji string is ditected
" Refered to http://iwsttty.hatenablog.com/entry/20110321/1300729749
let g:migemosearch_condition_to_use_migemo =
            \ get(g:, 'migemosearch_condition_to_use_migemo',
            \ '^\%(\\\a\)\=\(\(\(\([bdfghjkmnpstrz]\)\4\=\)\=y\=\([ei]\|[aou]h\=\)\)\|\%(ss\=\|dd\=\)\=h[aiuo]\|cc\=h[aio]\|tt\=su\|wa\|n\|-\)\+$')
let g:migemosearch_condition_to_extract_word =
            \ get(g:, 'migemosearch_condition_to_extract_word',
            \ '^\%(\\\a\)\=\zs\(\(\(\([bdfghjkmnpstrz]\)\4\=\)\=y\=\([ei]\|[aou]h\=\)\)\|\%(ss\=\|dd\=\)\=h[aiuo]\|cc\=h[aio]\|tt\=su\|wa\|n\|-\)\+$')

let g:loaded_migemosearch = 1

let &cpo = s:save_cpo
unlet s:save_cpo
