if [ -e $1 ]; then
    usage
else
    bashdb_$1 $@
fi;
