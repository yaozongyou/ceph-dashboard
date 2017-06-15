#!/bin/bash

dest="$1"
if [[ -z "$dest" ]]; then
    dest="data.go"
fi

echo -e "package main\n\n// this file is auto-generated by bundle.sh\n" > $dest

bundle() {
    for f in `find $1/ -type f`; do 
        echo -ne "\t\"$f\": \`" >> $dest
        cat $f |base64 -w 100 >> $dest
        echo -ne "\`,\n" >> $dest
    done
}

echo "var _bundle = map[string]string{" >> $dest

bundle templates
bundle static

echo -e "}" >> $dest
