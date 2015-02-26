"=============================================================================
" FILE: plugin/bsdcv.vim
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


if exists('g:loaded_bsdcv')
    finish
endif

if !exists('g:bsdcv_split_size')
    let g:bsdcv_split_size = ''
endif

if !exists('g:bsdcv_split_horizontal')
    let g:bsdcv_split_horizontal = 1
endif

if !exists('g:bsdcv_prefer_python3')
    let g:bsdcv_prefer_python3 = 1
endif

" TODO: bsdcv automatically searched all possible directories for bsdcv.vim to
" source from
augroup BSDCVFileTypeDetect
    autocmd! Syntax bsdcv call bsdcv#SourceSyntaxFile()
augroup END

" Map vimbsdcv#bsdcv command to BSDCV() function
command! -nargs=* BSDCV call bsdcv#BSDCV(<f-args>)
command! -nargs=* BSDCVCursor call bsdcv#BSDCV(expand('<cword>'))
