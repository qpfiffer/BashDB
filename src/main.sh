if [ ! -d $TABLENAME ]; then
    create_tables
fi
if [ -e $1 ]; then
    usage
else
    bashdb_$1 $@
fi;
