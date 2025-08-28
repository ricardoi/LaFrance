#!/bin/bash

dirl=$1  # file with names of directories

# create a new directory to store the spades results
mkdir -p spades_results

while IFS= read -r dir; do
    echo "Processing $dir"
    cp "${dir}/${dir}_out/scaffolds.fasta" "spades_results/${dir}_scaffolds.fasta"
done < "$dirl"

date
