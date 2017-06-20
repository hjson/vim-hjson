" Vim syntax file
" Language: Hjson
" Maintainer: Christian Zangl
" Version: 0.1
" Acknowledgement: Based off of vim/runtime/syntax/json.vim

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'hjson'
endif

syn match   hjsonNoise           /\%(:\|,\)/

" Syntax: Comments
syn match   hjsonLineComment   "\/\/.*"
syn match   hjsonLineComment2  "#.*"
syn region  hjsonComment       start="/\*" end="\*/"

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
syn match  hjsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n,}\]]/ contains=hjsonString
syn region  hjsonString oneline matchgroup=hjsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=hjsonEscape contained
" multiline:
syn match  hjsonMLStringMatch /'''\([\r\n]\|.\)\{-}'''/ contains=hjsonMLString
syn region  hjsonMLString matchgroup=hjsonQuote start=/'''/ end=/'''/ contained
" quoteless:
" currently not defined, not sure they can be implemented with this syntax

" Syntax: JSON Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  hjsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=hjsonKeyword
syn region  hjsonKeyword matchgroup=hjsonKeyword start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
" without quotes
syn match  hjsonKeywordMatch2 /[^][,:{}[:blank:]]\+\:/ contains=hjsonKeyword2
syn region  hjsonKeyword2 matchgroup=hjsonKeyword2 start=//  end=/\ze\:/ contained

" Syntax: Escape sequences
syn match   hjsonEscape    "\\["\\/bfnrt]" contained
syn match   hjsonEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   hjsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n,}\]]"

" Syntax: Boolean
syn match  hjsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  hjsonNull      null

" Syntax: Braces
syn region  hjsonFold matchgroup=hjsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  hjsonFold matchgroup=hjsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link hjsonComment         Comment
hi def link hjsonLineComment     Comment
hi def link hjsonLineComment2    Comment
"hi def link hjsonString          String
hi def link hjsonEscape          Character "Special
hi def link hjsonNumber          Number
hi def link hjsonBraces          Delimiter
hi def link hjsonNull            Function
hi def link hjsonBoolean         Boolean
hi def link hjsonKeyword         Label
hi def link hjsonKeyword2        Label
hi def link hjsonQuote           Character "Quote
hi def link hjsonNoise           Noise

let b:current_syntax = "hjson"
if main_syntax == 'hjson'
  unlet main_syntax
endif

" MIT License
" Copyright (c) 2013, Jeroen Ruigrok van der Werven, Eli Parra, Christian Zangl
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

