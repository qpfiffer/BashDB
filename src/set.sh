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

    # Truncate and right pad string to 32 characters
    KEY=$(echo -n $2 | cut -c-32 | sed -e :a -e 's/^.\{1,32\}$/&0/;ta')
    KEYHASH=$(echo $2 | sha1sum | awk '{ print $1 }')
    VAL_LENGTH=${#3}
    #echo "Key: $KEY Val length: $VAL_LENGTH"
    # Have meta file that is key/value with offset into values file
    # Hash key, use that to find the meta information
    # Traverse bash array until key is the same, then use that offset into the values file
    calc_idx $KEYHASH
    get_values_file_size

    OFFSET=$DBSIZE
    METASTR=`printf '%032s' $KEY``printf '%032d' $VAL_LENGTH``printf '%032d' $OFFSET`
    #echo "Writing $METASTR"
    #echo "Writing offset $OFFSET"

    ((TOWRITE = $METACHUNKSIZE + 1))
    dd conv=noerror,notrunc if=<(echo -n $METASTR) of=$METAFILE seek=$IDX bs=1 count=$TOWRITE &> /dev/null
    echo -n "$3" >> $VALUESFILE
}
