function usage {
cat << EOF
$0 $VERSION

usage: $0 [OPTIONS] [operation [arg [arg ...]]]
    -d <directory>  The location of the database to perform operations on.
                    Defaults to the current directory.
Operations:
    set <key> <value>   Sets the value for <key>.
    get <key>           Returns the value for <key>.
EOF
}
