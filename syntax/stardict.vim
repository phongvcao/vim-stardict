"=============================================================================
" FILE: autoload/stardict.vim
" AUTHOR: Phong V. Cao <phongvcao@phongvcao.com>
" License: MIT license {{{
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
" OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================


if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "stardict"

syntax match stardictResult "\v^[A-Z].*"
syntax match stardictWord "\v^\@.*"
syntax match stardictWordType "\v^\*.*"
syntax match stardictWordMeaning "\v^[0-9].*"
syntax match stardictWordExample "\v^(    \-\s.*\:|\!.*)"
syntax match stardictDictName "\v^\@[^/]*\:[^/]*"

highlight link stardictResult Special
highlight link stardictWord PreProc
highlight link stardictWordType Statement
highlight link stardictWordMeaning Identifier
highlight link stardictWordExample Type
highlight link stardictDictName Underlined
