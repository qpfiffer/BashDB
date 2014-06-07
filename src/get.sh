function bashdb_get {
    if [ -z "$2" ]; then
        echo "You need a key to retrieve."
        exit 1
    fi;

    get_meta_file
    get_values_file

    # Truncate and right pad string to 32 characters
    KEY=$(echo -n $2 | cut -c-32 | sed -e :a -e 's/^.\{1,32\}$/&0/;ta')
    KEYHASH=$(echo $2 | sha1sum | awk '{ print $1 }')

    calc_idx $KEYHASH

    OFFSET=$DBSIZE
    METASTR=`printf '%032s' $KEY``printf '%032d' $VAL_LENGTH``printf '%032d' $OFFSET`

    ((TOWRITE = $METACHUNKSIZE + 1))
    FUCKING_KEY=$(dd conv=noerror,notrunc if=$METAFILE skip=$IDX bs=1 count=$TOWRITE 2> /dev/null)
    RETRIEVED_KEY=$(echo -n $FUCKING_KEY | cut -c-33)
    RETRIEVED_VALUE_LENGTH=$(echo -n $FUCKING_KEY | cut -c33-65)
    RETRIEVED_OFFSET=$(echo -n $FUCKING_KEY | cut -c66-98)

    #echo "FUCKING VALUE: $FUCKING_KEY"
    #echo "Retrieved key: $RETRIEVED_KEY"
    #echo "          Key: $KEY"
    #echo "       Offset: $RETRIEVED_OFFSET"

    if [ -z "$RETRIEVED_KEY" ]; then
        #echo "No key retrieved."
        exit 1
    elif [ $RETRIEVED_KEY != $KEY ]; then
        #echo "Keys were not the same."
        exit 1
    fi

    ((RETRIEVED_VALUE_LENGTH = 10#$RETRIEVED_VALUE_LENGTH + 0)) # Convert the padded value to a regular integer
    #echo "Retrieved value length: $RETRIEVED_VALUE_LENGTH"
    ((RETRIEVED_OFFSET = 10#$RETRIEVED_OFFSET + 0)) # Convert the padded value to a regular integer
    #echo "Retrieved offset: $RETRIEVED_OFFSET"


    #echo "Key found."
    RETRIEVED_VALUE=$(dd conv=noerror,notrunc if=$VALUESFILE skip=$RETRIEVED_OFFSET bs=1 count=$RETRIEVED_VALUE_LENGTH 2> /dev/null)
    echo -n $RETRIEVED_VALUE
}
