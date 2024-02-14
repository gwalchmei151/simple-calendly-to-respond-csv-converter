#!/bin/bash

# Usage:
# bash calendlyToRespond.sh <infosession tag> <filename>
# OR, chmod +x and
# ./calendlyToRespond.sh <infosession tag> <filename> 
#
# e.g. bash calendlyToRespond.sh info190224 event-786887162-invitees-export.csv

infotag=$1

echo "First Name,Last Name,Phone Number,Email,Tags" > "${infotag}_respond.csv"

# Skip the header line from the input file and create a temporary file
tail -n +2 "$2" > "${infotag}_calendly.tmp"

# Use while read loop to read the file line by line correctly
while IFS= read -r line
do
    echo "$line" | awk -F, -v var="$infotag" '{print $1 "," "" "," $7 "," $4 "," var}' >> "${infotag}_respond.csv"
done < "${infotag}_calendly.tmp"

# Clean up temporary file
rm "${infotag}_calendly.tmp"
