#=============================================================================
# FILE: bindings/zsh/stardict.zsh
# AUTHOR: Phong V. Cao <phongvcao@phongvcao.com>
# License: MIT license {{{
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# }}}
#=============================================================================


export STARDICT_RESULT="\033[0;31m"
export STARDICT_WORD="\033[0;91m"
export STARDICT_WORD_TYPE="\033[0;32m"
export STARDICT_WORD_MEANING="\033[0;34m"
export STARDICT_WORD_EXAMPLE="\033[0;33m"
export STARDICT_DICT_NAME="\033[0;95m"
export STARDICT_PYTHON_PATH=""

if [[ -z ${STARDICT_DIR} ]]; then
    export STARDICT_DIR="${HOME}/.vim/bundle/vim-stardict"
fi


function stardict() {
for arg in "$@"; do
    if [[ -n "${STARDICT_PYTHON_PATH}" ]]; then
        "${STARDICT_PYTHON_PATH}" "${STARDICT_DIR}"/python/stardict.py "${arg}"
    else
        "${STARDICT_DIR}"/python/stardict.py "${arg}"
    fi
done
}


function vstardict() {
PYSCRIPT_DIR="${STARDICT_DIR}"/python
PYTHON_COMMAND="import sys; sys.path.insert(0, '"${PYSCRIPT_DIR}"')"
VIM_COMMAND="setlocal buftype=nofile bufhidden=hide noswapfile readonly filetype=stardict"

FINAL_DEFINITIONS=""
ARGS_LIST=""

for arg in "$@"; do
    FINAL_DEFINITIONS+="$(python -c "${PYTHON_COMMAND}; import stardict; print(stardict.getDefinition([['$arg']]))")""\n""\n"
done

echo -e "${FINAL_DEFINITIONS}" | vim -c "${VIM_COMMAND}" -
}
