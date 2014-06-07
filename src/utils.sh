function get_table_size {
    DBSIZE=$(stat $TABLENAME | grep 'Size' | awk '{ print $2 }')
}
function bashdb_meta {
    get_table_size
    echo "Database is $DBSIZE bytes long."
}
function create_tables {
    mkdir $TABLENAME
    truncate -s $HASHBLOCK'K' $TABLENAME/$TABLENAME'.0'$TABLEEXT
    get_table_size
}
