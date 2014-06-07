function bashdb_get {
    if [ -z "$2" ]; then
        echo "You need a key to retrieve."
        exit 1
    fi;
}
