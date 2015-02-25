function stardict() {
for arg in "$@"; do
    $( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../python && pwd)/stardict.py "${arg}"
done
}
