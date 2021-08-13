#!/bin/sh

WORKING_DIR=/tmp
ICS_URL="https://calendar.google.com/calendar/ical/calendario.eventos.pt%40gmail.com/public/basic.ics"
LIST_URL="https://project-gc.com/Tools/ComingEvents?country=Portugal&submit=Filter"

cd $WORKING_DIR
curl -s $ICS_URL | grep -o 'GC.....' | sort > calendario.txt
curl -s $LIST_URL | xmllint --html --xpath "//tbody//a/text()" - 2> /dev/null | awk '{while(length($0)>=7){print substr($0,1,7);$0=substr($0,8)}}' | sort > eventos.txt

comm -1 -3 calendario.txt eventos.txt

rm calendario.txt
rm eventos.txt
