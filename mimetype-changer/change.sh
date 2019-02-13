#!/bin/bash
DEFAULTS_LIST="/usr/share/applications/defaults.list"
MIMETYPES=$(cat $1 | sed ':a;N;$!ba;s/\n/ /g')

for mime in $MIMETYPES; do
    atual=$(cat $DEFAULTS_LIST | grep $mime)
    novo=$(cat $DEFAULTS_LIST | grep $mime | awk -F "=" {'print $1'})"="$2
    sed -i "s#${atual}#${novo}#" $DEFAULTS_LIST
done