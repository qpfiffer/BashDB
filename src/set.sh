function bashdb_set {
    if [ -z "$2" ]; then
        echo "You need a key to set."
        exit 1
    fi;
    if [ -z "$3" ]; then
        echo "You need a value to set."
        exit 1
    fi;

    get_meta_file
    get_values_file

    echo "Key: $2"
    KEY=$2
    KEYHASH=$(echo $2 | sha1sum | awk '{ print $1 }')
    # Have meta file that is key/value with offset into values file
    # Hash key, use that to find the meta information
    # Traverse bash array until key is the same, then use that offset into the values file
    calc_idx $KEYHASH
    get_values_file_size

    OFFSET=$DBSIZE
    METASTR=`printf '%064d' $KEY``printf '%064d' $OFFSET`

    dd conv=noerror,notrunc if=<(echo -n $METASTR) of=$METAFILE seek=$IDX bs=1 count=$METACHUNKSIZE
    echo -n "$3" >> $VALUESFILE
}
