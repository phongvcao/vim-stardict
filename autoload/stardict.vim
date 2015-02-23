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


function! stardict#StarDict(...)
    let expl=system('sdcv -n ' . join(a:000, '\\ '))
    silent! execute 'bd vim-stardict'

    if (g:stardict_split_horizontal ==# 1)
        silent! execute g:stardict_split_size . 'sp vim-stardict'
    else
        silent! execute g:stardict_split_size . 'vsp vim-stardict'
    endif

    setlocal buftype=nofile bufhidden=hide noswapfile readonly filetype=stardict
    silent! 1s/^/\=expl/
    1

    call stardict#FormatBuffer()
endfunction


function! stardict#SourceSyntaxFile()
    let l:syntax_file_0 = '/usr/share/vim/vimfiles/syntax/stardict.vim'
    let l:syntax_file_1 = '~/.vim/plugin/syntax/stardict.vim'
    let l:syntax_file_2 = '~/.vim/bundle/stardict.vim/syntax/stardict.vim'

    if filereadable(expand(l:syntax_file_0))
        silent! execute 'source ' . l:syntax_file_0
        let g:stardict_syntax_file = l:syntax_file_0

    elseif filereadable(expand(l:syntax_file_1))
        silent! execute 'source ' . l:syntax_file_1
        let g:stardict_syntax_file = l:syntax_file_1

    elseif filereadable(expand(l:syntax_file_2))
        silent! execute 'source ' . l:syntax_file_2
        let g:stardict_syntax_file = l:syntax_file_2

    endif
endfunction


function! stardict#FormatBuffer()
    let l:replaced_bullet = 1
    let l:replaced_str = ''
    let l:line_num = 1
    let l:word_meaning_pattern = '\v^\-\s+.*'
    let l:word_example_pattern = '\v^\=.*'
    let l:word_multi_examples_pattern = '\v^\!.*'
    let l:word_pattern = '\v^\@.*'
    let l:dict_name_pattern = '\v^\-\-\>.*'

    while l:line_num <= line('$')
        let l:line = getline(l:line_num)

        " The order of the if/elseif statements matter to the logic flow of this
        " function

        if (match(l:line, l:word_example_pattern) !=# -1)
            " Re-format WordExample
            let l:replaced_str = substitute(l:line, '\v^\=\s*', '\t- ', 'g')
            let l:replaced_str = substitute(l:replaced_str, '\v\+\s*', ': ', 'g')
            call setline(l:line_num, l:replaced_str)

        elseif (match(l:line, l:word_meaning_pattern) !=# -1)
            " Re-format WordMeaning
            let l:prev_line = getline(l:line_num - 1)

            if (match(l:prev_line, l:word_multi_examples_pattern) !=# -1)
                let l:replaced_str = substitute(l:line, '\v^\-', '\t\t-', 'g')
            else
                let l:replaced_str = substitute(l:line, '\v^\-\s+', l:replaced_bullet . '. ', 'g')
                let l:replaced_bullet = l:replaced_bullet + 1
            endif

            call setline(l:line_num, l:replaced_str)

        elseif (match(l:line, l:word_pattern) !=# -1)
            " Re-format Word
            let l:replaced_str = substitute(l:line, '\v^\@', '', 'g')
            call setline(l:line_num, l:replaced_str)
            let l:replaced_bullet = 1

        endif

        let l:line_num = l:line_num + 1
    endwhile

    let l:replaced_bullet = 1
    let l:replaced_str = ''
    let l:line_num = 1
    while l:line_num <= line('$')
        let l:line = getline(l:line_num)

        if (match(l:line, l:word_multi_examples_pattern) !=# -1)
            let l:replaced_str = substitute(l:line, '\v^\!(.*)', '\t- \1:', 'g')
            call setline(l:line_num, l:replaced_str)

        elseif (match(l:line, l:dict_name_pattern) !=# -1)
            let l:replaced_str = substitute(l:line, '\v^\-\-\>', '@Dictionary: ', 'g')
            call setline(l:line_num, l:replaced_str)

            let l:line_num = l:line_num + 1
            let l:line = getline(l:line_num)
            let l:replaced_str = substitute(l:line, '\v^\-\-\>', '@SearchedTerm: ', 'g')
            call setline(l:line_num, l:replaced_str)
        endif

        let l:line_num = l:line_num + 1
    endwhile
endfunction
