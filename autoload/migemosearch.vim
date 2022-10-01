let s:save_cpo = &cpo
set cpo&vim

function! s:has_vimproc()
    if !exists('s:exists_vimproc')
        try
            silent call vimproc#version()
            let s:exists_vimproc = 1
        catch
            let s:exists_vimproc = 0
        endtry
    endif

    return s:exists_vimproc
endfunction

function! migemosearch#system(...)
    return call(s:has_vimproc() ? 'vimproc#system' : 'system', a:000)
endfunction

function! s:find_dict(name)
    let path = $VIM . ',' . &runtimepath
    let dict = globpath(path, "dict/".a:name)

    if dict ==# ''
        let dict = globpath(path, a:name)
    endif

    for dir in [ '/usr/share/migemo/',
               \ '/usr/local/share/migemo/',
               \ '/usr/share/cmigemo/'
               \ '/opt/homebrew/share/']
        if dict ==# '' && filereadable(dir.a:name)
            let dict = dir.a:name
        endif
    endfor

    let dict = matchstr(dict, "^[^\<NL>]*")

    return dict
endfunction

function! s:detect_dict()
    for p in [ 'migemo/'.&encoding.'/migemo-dict',
             \ &encoding.'/migemo-dict',
             \ 'migemo-dict' ]
        let dict = s:find_dict(p)
        if dict != ''
            return dict
        endif
    endfor

    echoerr 'a dictionary for migemo is not found'
    echoerr 'your encoding is '.&encoding
endfunction

if has('migemo') && g:migemosearch_use_kaoriya_migemo
    if &migemodict == '' || !filereadable(&migemodict)
        let &migemodict = s:detect_dict()
    endif

    function! migemosearch#generate_regex(word)
        return migemo(a:word)
    endfunction
else
    " non-builtin version
    if g:migemosearch_migemodict ==# ''
        let g:migemosearch_migemodict = s:detect_dict()
    endif

    function! migemosearch#generate_regex(word)
        if ! executable(g:migemosearch_cmigemo)
            echoerr 'Error: cmigemo is not installed'
            return ''
        endif

        if a:word == ''
            echoerr 'Error: word to search is empty'
            return ''
        endif

        return migemosearch#system(g:migemosearch_cmigemo.' -v -w "'.a:word.'" -d "'.g:migemosearch_migemodict.'"')
    endfunction
endif

function! migemosearch#replace_search_word()
    if getcmdtype() ==# '/' || getcmdtype() ==# '?'
        let cmdline = getcmdline()
        if cmdline =~# g:migemosearch_condition_to_use_migemo
            return "\<C-u>".migemosearch#generate_regex(matchstr(cmdline, g:migemosearch_condition_to_extract_word))
        endif
    endif

    return ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
