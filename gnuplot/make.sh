#!/usr/bin/env bash
#echo "Number of arguments:" $#
if [ "$#" -ne 1 ]; then
    echo "What would you like to build?"
    exit 1
fi

CFLAGS="-Wall -g -O2 -std=c99"
LDFLAGS="-lm"
infile="$1.c"

gcc ${CFLAGS} ${infile} -o $1 ${LDFLAGS}
echo "Done"
