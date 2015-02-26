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


" This is for setting up PYTHONPATH
let s:script_folder_path = escape(expand('<sfile>:p:h'), '\')


function! s:SetPythonPath() abort
    if (g:stardict_prefer_python3) || has('python3')
        python3 import sys
        python3 import vim
        execute 'python3 sys.path.insert(0, "' . s:script_folder_path . '/../python")'
    elseif has('python')
        python import sys
        python import vim
        execute 'python sys.path.insert(0, "' . s:script_folder_path . '/../python")'
    endif

    return 1
endfunction


function! stardict#StarDict(...)
    let l:expl=stardict#GetDefinition(a:000)
    bufdo if (&filetype ==# 'stardict') | let l:cur_file_name=expand('%') | endif

    if exists('l:cur_file_name')
        silent! execute 'bd ' . l:cur_file_name
    endif

    if (g:stardict_split_horizontal ==# 1)
        silent! execute g:stardict_split_size . 'sp vim-stardict'
    else
        silent! execute g:stardict_split_size . 'vsp vim-stardict'
    endif

    setlocal buftype=nofile bufhidden=hide noswapfile readonly filetype=stardict
    silent! 1s/^/\=l:expl/
    1

endfunction


function! stardict#GetDefinition(...)
    if s:SetPythonPath() != 1
        return "Cannot set ${PATH} variable!"
    endif

    let l:argsStr = join(a:000, '\\ ')

    if (g:stardict_prefer_python3) || has('python3')
        python3 definition = GetDefinitionInner(vim.eval('a:000'))
        let l:definition = py3eval('definition')
    elseif has('python')
        python definition = GetDefinitionInner(vim.eval('a:000'))
        let l:definition = pyeval('definition')
    endif

    return l:definition
endfunction

if (g:stardict_prefer_python3)
python3 << EOF
def GetDefinitionInner(argsStr):
    import stardict

    return stardict.getDefinition(argsStr)
EOF
else
python << EOF
def GetDefinitionInner(argsStr):
    import stardict

    return stardict.getDefinition(argsStr)
EOF
endif

function! stardict#SourceSyntaxFile()
    let l:syntax_file_0 = '~/.vim/bundle/stardict/syntax/stardict.vim'
    let l:syntax_file_1 = '~/.vim/plugin/syntax/stardict.vim'
    let l:syntax_file_2 = '/usr/share/vim/vimfiles/syntax/stardict.vim'

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
