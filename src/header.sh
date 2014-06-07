#!/bin/bash -e
DBSIZE=-1
HASHBLOCK=16M
METABLOCK=4M
METAEXT=.meta
METACHUNKSIZE=96 # 32-bit integer padded with zeroes + 32-bit offset padded with zeroes (also an integer)

TABLENAME=./bashdb_data
TABLEEXT=.data

VALUESFILE=$TABLENAME/$TABLENAME$TABLEEXT
METAFILE=$TABLENAME/$TABLENAME$METAEXT
VERSION=0.1

IDX=0

