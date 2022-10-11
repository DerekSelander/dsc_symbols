#!/bin/bash
#set -x

IMAGES=$(ssh root@$1 "/usr/local/bin/dsdump -l" | grep -v \* | awk '{print $2}' )
#echo -e $IMAGES |  head -1 | while read IMAGE; do echo "dumping $IMAGE";  ssh root@$1 "/usr/local/bin/dsdump -v $IMAGE -U -p" | awk  '{print "|| " $2 "\ " $3}' | sort ; done
while IFS= read -r line ; do echo "processing \"$line\""; mkdir -p "./$(dirname $line)";  ssh root@$1 "/usr/local/bin/dsdump $line -v -U -p" < /dev/null  |  awk  '{print "|| " $2 "\ " $3}' | sort  > ".$line" ;  ssh root@$1 "/usr/local/bin/dsdump $line -v -U -P" < /dev/null  |  awk  '{print "   " $2 "\ " $3}' | grep -v "\<redacted\>" | sort  >> ".$line";   done <<< "${IMAGES}"
#while IFS= read -r line ; do mkdir -p "./$(dirname $line)"; ssh root@$1 "/usr/local/bin/dsdump $line -v -U -p" |  awk  '{print "|| " $2 "\ " $3}' >  ".$line";   done <<< "${IMAGES}"
#while IFS= read -r line ; do mkdir -p "./$(dirname $line)"; ssh root@$1 "/usr/local/bin/dsdump $line -v -U -p" |  awk  '{print "|| " $2 "\ " $3}' >  ".$line";   done <<< "${IMAGES}"
#echo -e $IMAGES |  head -1 | while read IMAGE; do echo "dumping $IMAGE";  ssh root@$1 "echo $IMAGE"; done
