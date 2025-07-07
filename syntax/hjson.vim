" Vim syntax file
" Language: Hjson
" Maintainer: Christian Zangl
" Version: 1.0
" Acknowledgement: Based off of vim/runtime/syntax/json.vim

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'hjson'
endif

" quoteless Strings (has least priority)
syn match   hjsonStringUQ      /[^ \t,:[\]{}].*$/

syn match   hjsonNoise         /\%(:\|,\)/

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
syn match   hjsonStringMatch /"\([^"]\|\\\"\)*"/ contains=hjsonString
syn region  hjsonString oneline matchgroup=hjsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=hjsonEscape contained
syn match   hjsonStringMatchSQ /'\([^']\|\\\'\)*'/ contains=hjsonStringSQ
syn region  hjsonStringSQ oneline matchgroup=hjsonQuote start=/'/  skip=/\\\\\|\\'/  end=/'/ contains=hjsonEscape contained
" multiline:
syn match   hjsonStringMatchML /'''\([\r\n]\|.\)\{-}'''/ contains=hjsonStringML
syn region  hjsonStringML matchgroup=hjsonQuote start=/'''/ end=/'''/ contained

" Syntax: Numbers
syn match   hjsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze\s*\($\|[\]}#,]\|\/\/\|\/\*\)"

" Syntax: Boolean
syn match   hjsonBoolean   /\(true\|false\)\ze\s*\($\|[\]}#,]\|\/\/\|\/\*\)/

" Syntax: Null
syn match   hjsonNull      /null\ze\s*\($\|[\]}#,]\|\/\/\|\/\*\)/

" Syntax: JSON Object Keywords
" Separated into a match and region because a region by itself is always greedy
" without quotes
syn match   hjsonKeywordMatch /\(:\_s*\)\@<![^,:[\]{}[:blank:]]\+\_s*:/ contains=hjsonKeyword
syn region  hjsonKeyword matchgroup=hjsonQuote start=//  end=/\ze\_s*:/ contained
" with quotes
syn match   hjsonKeywordMatchQ /"\([^"]\|\\\"\)\+"\_s*:/ contains=hjsonKeywordQ,hjsonEscape
syn region  hjsonKeywordQ matchgroup=hjsonQuote start=/"/  end=/"\ze\_s*:/ contains=hjsonEscape contained
syn match   hjsonKeywordMatchSQ /'\([^']\|\\\'\)\+'\_s*:/ contains=hjsonKeywordSQ,hjsonEscape
syn region  hjsonKeywordSQ matchgroup=hjsonQuote start=/'/  end=/'\ze\_s*:/ contains=hjsonEscape contained

" Syntax: Escape sequences
syn match   hjsonEscape    "\\["'\\/bfnrt]" contained
syn match   hjsonEscape    "\\u\x\{4}" contained

" Syntax: Array/Object Braces
syn region  hjsonFold matchgroup=hjsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  hjsonFold matchgroup=hjsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Syntax: Comments
syn match   hjsonLineComment   "\/\/.*"
syn match   hjsonLineComment2  "#.*"
syn region  hjsonComment       start="/\*" end="\*/"

" Define the default highlighting.
hi def link hjsonComment         Comment
hi def link hjsonLineComment     hjsonComment
hi def link hjsonLineComment2    hjsonComment
hi def link hjsonString          String
hi def link hjsonStringSQ        hjsonString
hi def link hjsonStringML        hjsonString
hi def link hjsonStringUQ        hjsonString
hi def link hjsonEscape          Special
hi def link hjsonNumber          Type
hi def link hjsonBraces          Delimiter
hi def link hjsonNull            Type
hi def link hjsonBoolean         Type
hi def link hjsonKeyword         Label
hi def link hjsonKeywordQ        hjsonKeyword
hi def link hjsonKeywordSQ       hjsonKeyword
hi def link hjsonQuote           Delimiter
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

