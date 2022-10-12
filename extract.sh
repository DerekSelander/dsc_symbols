#!/bin/bash
#set -x

ssh -n root@$1 'OUT_BASE="/tmp/dsc_symbols"; rm -rf $OUT_BASE; mkdir -p "$OUT_BASE"; /usr/local/bin/dsdump -l | grep -v \* | awk '"'"'{print $2}'"'"' | while read line; do echo  "processing \"$line\""; mkdir -p "$OUT_BASE/$(dirname $line)"; /usr/local/bin/dsdump "$line" -vUp | awk '"'"'{print "|| " $2 " " $3}'"'"' | sort > "$OUT_BASE/$line"; /usr/local/bin/dsdump "$line" -vvu | awk '"'"'{print "   " $2 " " $3}'"'"'  | sort >> "$OUT_BASE/$line"; if /usr/local/bin/dsdump "$line" -vU | grep OBJC_CLASS_; then /usr/local/bin/dsdump -o "$line" >> "$OUT_BASE/$line"; fi  ; done'


echo "extracted some shit"
ssh root@$1 "tar -zcf /tmp/dsc_symbols.zip /tmp/dsc_symbols"
scp "root@$1:/tmp/dsc_symbols.zip" "/tmp/dsc_symbols.zip"

open -R "/tmp/dsc_symbols.zip"
