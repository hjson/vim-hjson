" Vim indentation file
" Language: Hjson
" Version: 1.0

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent
setlocal indentexpr=GetHjsonIndent(v:lnum)
setlocal indentkeys=!^F,],},o,O

function! GetHjsonIndent(lnum)
    " First line has indent 0
    if a:lnum == 1
        return 0
    endif

    let increase = (getline(a:lnum-1) =~ '[{\[]\s*\(\(//\|#\).*\)\{0,1\}$')
    let decrease = (getline(a:lnum) =~ '^\s*[}\]]')
    let base = indent(a:lnum-1)

    return base + (increase - decrease) * shiftwidth()
endfunction
