if exists('g:loaded_migemosearch')
    finish
endif

let g:migemosearch_cmigemo = get(g:, 'migemosearch_cmigemo', 'cmigemo')
let g:migemosearch_migemodict = get(g:, 'migemosearch_migemodict', '')
let g:migemosearch_condition_to_use_migemo = get(g:, 'migemosearch_condition_to_use_migemo', '^\%(\\\a\)\=\%(\l\|-\)\+$')
let g:migemosearch_condition_to_extract_word = get(g:, 'migemosearch_condition_to_extract_word', '^\%(\\\a\)\=\zs\%(\l\|-\)\+$')

let g:loaded_migemosearch = 1
