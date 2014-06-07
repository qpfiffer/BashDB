function bashdb_set {
    if [ -z "$2" ]; then
        echo "You need a key to set."
        exit 1
    fi;
    if [ -z "$3" ]; then
        echo "You need a value to set."
        exit 1
    fi;

    echo "Key: $2"
    KEYHASH=$(echo $2 | sha1sum | awk '{ print $1 }')
    # Have meta file that is key/value with offset into values file
    # Hash key, use that to find the meta information
    # Traverse bash array until key is the same, then use that offset into the values file
    calc_idx $KEYHASH
}
