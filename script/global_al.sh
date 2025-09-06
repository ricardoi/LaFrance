#!/bin/bash
#

file=$1
id=$2
max=$3

if [ $4 = "-self" ]
then
	while IFS= read -r FILENAME; do
		echo "$FILENAME"
		vsearch --makeudb_usearch $FILENAME --output $FILENAME.vdb
		vsearch --usearch_global $FILENAME -db $FILENAME.vdb --id "$id" --maxhits "$max" --self --userout $FILENAME.csv --userfields query+target+id+alnlen+mism+opens+qlo+qhi+tlo+thi+evalue+bits --threads  6
	#	vsearch --allpairs_global "$FILENAME" --id "$id" --alnout "$FILENAME.out"
	done < "$file"
elif [ $4 = "-global" ]
then
        while IFS= read -r FILENAME; do
                echo "$FILENAME"
                #vsearch --makeudb_usearch $FILENAME --output $FILENAME.vdb
                vsearch --allpairs_global $FILENAME --id "$id" --alnout $FILENAME-global-aln.txt --blast6out $FILENAME-global-aln.csv --threads  6
        done < "$file"
else
 	while IFS= read -r FILENAME; do
                echo "$FILENAME"
                vsearch --makeudb_usearch $FILENAME --output $FILENAME.vdb
                vsearch --usearch_global $FILENAME -db $FILENAME.vdb --id "$id" --maxhits "$max" --userout $FILENAME-self.csv --userfields query+target+id+alnlen+mism+opens+qlo+qhi+tlo+thi+evalue+bits --threads  6
        #       vsearch --allpairs_global "$FILENAME" --id "$id" --alnout "$FILENAME.out"
        done < "$file"
fi

