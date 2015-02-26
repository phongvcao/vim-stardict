function stardict() {
if [[ "$1" == "-e" || "$1" == "--editor" ]]; then
    PYSCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../python && pwd)
    PYTHON_COMMAND="import sys; sys.path.insert(0, '"${PYSCRIPT_DIR}"')"
    VIM_COMMAND="setlocal buftype=nofile bufhidden=hide noswapfile readonly filetype=stardict"
    python -c "${PYTHON_COMMAND}; import stardict; print(stardict.getDefinition([['$2']]))" | vim -c "${VIM_COMMAND}" -
else
    for arg in "$@"; do
        $( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../python && pwd)/stardict.py "${arg}"
    done
fi
}
