function bashdb_set {
    if [ -z "$2" ]; then
        echo "You need a key to set."
        exit 1
    fi;
    if [ -z "$3" ]; then
        echo "You need a value to set."
        exit 1
    fi;
}
