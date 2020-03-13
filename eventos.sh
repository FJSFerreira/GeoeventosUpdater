#!/bin/sh

WORKING_DIR=/tmp
ICS_URL="https://calendar.google.com/calendar/ical/geoeventospt%40gmail.com/public/basic.ics"
LIST_URL="https://project-gc.com/Tools/ComingEvents?country=Portugal&submit=Filter"

cd $WORKING_DIR
curl -s $ICS_URL | grep -o 'GC.....' > calendario.txt
curl -s $LIST_URL | xmllint --html --xpath "//tbody//a/text()" - 2> /dev/null | awk '{while(length($0)>=7){print substr($0,1,7);$0=substr($0,8)}}' > eventos.txt

#awk '{print $1}' eventos_temp.txt > eventos.txt
while read evento; do echo -n "+ $evento "; grep -c $evento calendario.txt; done < eventos.txt | grep " 0" | awk '{print $1 " " $2}'
while read evento; do echo -n "- $evento "; grep -c $evento eventos.txt; done < calendario.txt | grep " 0" | awk '{print $1 " " $2}'

#rm eventos_temp.txt
rm eventos.txt
rm calendario.txt
