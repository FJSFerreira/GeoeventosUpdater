#!/bin/sh

WORKING_DIR=~/Downloads
ICS_URL="https://calendar.google.com/calendar/ical/geoeventospt%40gmail.com/public/basic.ics"
LIST_URL="https://project-gc.com/Tools/ComingEvents?country=Portugal&submit=Filter"

cd $WORKING_DIR
curl -s $ICS_URL > basic.ics
curl -s $LIST_URL | xmllint --html --xpath "//tbody//a/text()" - 2> /dev/null | awk '{while(length($0)>=7){print substr($0,1,7);$0=substr($0,8)}}' > eventos.txt

#awk '{print $1}' eventos_temp.txt > eventos.txt
while read evento; do echo -n "$evento "; grep -c $evento basic.ics; done < eventos.txt | grep " 0" | awk '{print $1}'

#rm eventos_temp.txt
rm eventos.txt
rm basic.ics
