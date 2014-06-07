function get_values_file {
    VALUESFILE=$TABLENAME/$TABLENAME$TABLEEXT
}
function get_meta_file {
    METAFILE=$TABLENAME/$TABLENAME$METAEXT
}
function get_values_file_size {
    get_values_file
    DBSIZE=$(stat $VALUESFILE | grep 'Size' | awk '{ print $2 }')
}
function get_meta_file_size {
    get_meta_file
    METASIZE=$(stat $METAFILE | grep 'Size' | awk '{ print $2 }')
}
function bashdb_meta {
    get_table_size
    echo "Database is $DBSIZE bytes long."
}
function create_tables {
    get_values_file
    get_meta_file

    mkdir $TABLENAME

    # We just append values to the end of the bash file
    touch $VALUESFILE
    truncate -s $METABLOCK $METAFILE

    get_values_file_size
}
function create_required_partitions {
    REQUIRED_EXTRA_SIZE=$1
}
function calc_idx {
    HASH=$1

    get_meta_file_size
    ((TABLESIZE_MINUS_ONE = ($METASIZE / $METACHUNKSIZE) - 1))
    ((IDX = 16#$HASH & $TABLESIZE_MINUS_ONE))
    #echo "Index: $IDX"
}
