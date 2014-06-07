function usage {
cat << EOF
$0 $VERSION

usage: $0 [operation [arg [arg ...]]]
Operations:
    set <key> <value>   Sets the value for <key>.
    get <key>           Returns the value for <key>.
EOF
}
