#!/bin/bash
#set -x

ssh -n root@$1 'OUT_BASE="/tmp/dsc_symbols"; mkdir -p "$OUT_BASE"; /usr/local/bin/dsdump -l | grep -v \* | awk '"'"'{print $2}'"'"' | while read line; do echo  "processing \"$line\""; mkdir -p "$OUT_BASE/$(dirname $line)"; /usr/local/bin/dsdump "$line" -vUp | awk '"'"'{print "|| " $2 " " $3}'"'"' | sort > "$OUT_BASE/$line"; /usr/local/bin/dsdump "$line" -vUP | awk '"'"'{print "   " $2 " " $3}'"'"' | grep -v "\<redacted\>" | sort >> "$OUT_BASE/$line" ; done'


echo "extracted some shit"
ssh root@$1 "tar -zcf /tmp/dsc_symbols.zip /tmp/dsc_symbols"
scp "root@$1:/tmp/dsc_symbols.zip" "/tmp/dsc_symbols.zip"

