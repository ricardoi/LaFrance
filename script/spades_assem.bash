#!/bin/bash

# reading fastq files
find . -type f -name "*.gz" | cut -d/ -f2 | uniq > files.fof

echo "processing files.fof"

echo "Assembling reads with Spades" spades.py -v
while IFS= read -r line
do
  echo "assembling" $line "reads" 
  cd "$line"
  mkdir "$line"_out
  spades.py --rnaviral -1 "$line"_R1.fq.gz -2 "$line"_R2.fq.gz -t 10  -o "$line"_out
  cd ..
done < files.fof
