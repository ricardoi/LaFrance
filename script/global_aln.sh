#!/bin/bash

file=$1 # file of files
id=$2 # Identity threshold
max=$3 # Max number of hits

while IFS= read -r FILENAME; do
	echo "$FILENAME"
	vsearch --makeudb_usearch $FILENAME --output $FILENAME.vdb
	vsearch --usearch_global $FILENAME -db $FILENAME.vdb --id "$id" --maxhits "$max" --self --userout $FILENAME.csv --userfields "query+target+id+alnlen+mism+opens+qlo+qhi+tlo+thi+evalue+bits" --threads  6
#	vsearch --allpairs_global "$FILENAME" --id "$id" --alnout "$FILENAME.out"
done < "$file"
